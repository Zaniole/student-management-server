import express from 'express'
import con from '../utils/db.js'
import jwt from 'jsonwebtoken'

const router = express.Router()

router.post('/login', (req,res) => {
    const sql = "SELECT * FROM admin WHERE username = ? and password = ?"
    con.query(sql,[req.body.username, req.body.password], (err, result) => {
        if(err) return res.json({loginStatus: false, Error: err})
        if(result.length > 0){
            const username = result[0].username;
            const token = jwt.sign(
                {
                    //role: 'admin',
                    username: username
                },
                "secret_web_token",
                {
                    expiresIn:"1h"
                }
            )
            res.cookie('token', token);
            return res.json({loginStatus: true})
        } else {
            return res.json({loginStatus: false, Error:"wrong username or password"})
        }
    })
})

router.get('/logout', (req,res) => {
    res.clearCookie('token');
    return res.json({Status: true})
})

// Điểm danh và vắng
router.get('/absent/:id', (req, res) => {
    const id = req.params.id;
    const sql = `SELECT A.*, S.name, C.class_name
                FROM absent A 
                JOIN student S ON S.id = A.student_id 
                JOIN class C ON S.class_id = C.id 
                WHERE A.student_id = ?
                ORDER BY A.date`;
    con.query(sql, [id], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query error: " + err });
        return res.json({ Status: true, Result: result });
    })
})

router.get('/absent', (req, res) => {
    const sql = `SELECT S.id, S.name, C.class_name, COUNT(A.student_id) AS absent_count 
                FROM student S 
                LEFT JOIN absent A ON S.id = A.student_id 
                LEFT JOIN class C ON S.class_id = C.id 
                GROUP BY S.id, S.name, C.class_name`;
    con.query(sql, (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query error" });
        return res.json({ Status: true, Result: result });
    })
})

router.delete('/delete_absent/:id', (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM absent WHERE id = ?"
    con.query(sql, [id], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query Error" + err })
        return res.json({ Status: true, Result: result })
    })
})

router.post('/add_absent', (req, res) => {
    const value = [
        req.body.newAbsent.student_id,
        req.body.newAbsent.date,
        req.body.newAbsent.note
    ]
    const sql = "INSERT INTO absent (`student_id`,`date`,`note`) VALUES (?)"
    con.query(sql, [value], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query error" + err });
        return res.json({ Status: true });
    })
})

//Thông tin cơ bản học sinh
router.get('/student', (req, res) => {
    const sql = `SELECT student.*, class.class_name 
                FROM student 
                JOIN class ON student.class_id = class.id
                ORDER BY student.id`;
    con.query(sql, (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query error" });
        return res.json({ Status: true, Result: result });
    })
})

router.get('/student/:id', (req, res) => {
    const id = req.params.id
    const sql = `SELECT student.*, class.class_name 
                FROM student 
                JOIN class ON student.class_id = class.id
                WHERE student.id = ?`;
    con.query(sql, [id], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query error" });
        return res.json({ Status: true, Result: result });
    })
})

router.post('/add_student', (req, res) => {
    const sql = `INSERT INTO student (name, class_id) VALUES (?)`;
    const values = [
        req.body.name,
        req.body.class_id
    ];

    con.beginTransaction((err) => {
        if (err) return res.json({ Status: false, Error: "Transaction begin error: " + err });

        con.query(sql, [values], (err, result) => {
            if (err) {
                return con.rollback(() => {
                    res.json({ Status: false, Error: "Query error: " + err });
                });
            }

            const id = result.insertId;

            const sql1 = `INSERT INTO marks (student_id) VALUES (?);`;
            const sql2 = `INSERT INTO essay (student_id) VALUES (?);`;
            const sql3 = `INSERT INTO basic_skills (student_id) VALUES (?);`;
            const sql4 = `INSERT INTO multiple_choice (student_id) VALUES (?);`;

            con.query(sql1, [id], (err, result) => {
                if (err) {
                    return con.rollback(() => {
                        res.json({ Status: false, Error: "Query error: " + err });
                    });
                }

                con.query(sql2, [id], (err, result) => {
                    if (err) {
                        return con.rollback(() => {
                            res.json({ Status: false, Error: "Query error: " + err });
                        });
                    }

                    con.query(sql3, [id], (err, result) => {
                        if (err) {
                            return con.rollback(() => {
                                res.json({ Status: false, Error: "Query error: " + err });
                            });
                        }

                        con.query(sql4, [id], (err, result) => {
                            if (err) {
                                return con.rollback(() => {
                                    res.json({ Status: false, Error: "Query error: " + err });
                                });
                            }

                            con.commit((err) => {
                                if (err) {
                                    return con.rollback(() => {
                                        res.json({ Status: false, Error: "Commit error: " + err });
                                    });
                                }

                                res.json({ Status: true, Result: result });
                            });
                        });
                    });
                });
            });
        });
    });
});



// Thông tin lớp
router.get('/class', (req, res) => {
    const sql = `SELECT class.*, COUNT(student.id) AS student_count 
                FROM class 
                LEFT JOIN student ON class.id = student.class_id 
                GROUP BY class.class_name`;
    con.query(sql, (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query error" });
        return res.json({ Status: true, Result: result });
    })
})

router.get('/class/:id', (req, res) => {
    const id = req.params.id;
    const sql = `SELECT 
                    S.id, S.name, C.class_name,
                    M.entrance_mark, M.semester_1_mark, M.year_mark, 
                    BS.listening, BS.speaking, BS.reading, BS.writing, 
                    E.first AS e_first, E.second AS e_second, E.third AS e_third, E.fourth AS e_fourth,
                    MC.first, MC.second, MC.third, MC.fourth 
                FROM Student S 
                LEFT JOIN multiple_choice MC ON S.id = MC.student_id 
                LEFT JOIN marks M ON S.id = M.student_id 
                LEFT JOIN basic_skills BS ON S.id = BS.student_id 
                LEFT JOIN essay E ON S.id = E.student_id
                LEFT JOIN class C ON S.class_id = C.id 
                WHERE S.class_id = ? 
                GROUP BY S.id;`;
    con.query(sql, [id], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query error" + err });
        return res.json({ Status: true, Result: result });
    })
})

router.post('/add_class', (req, res) => {
    //console.log(req.body);
    const sql = "INSERT INTO class (`class_name`) VALUES (?)"
    con.query(sql, [req.body.newClass], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query error" });
        return res.json({ Status: true });
    })
})

// thông tin học tập của học sinh
router.get('/get_marks/:id', (req, res) => {
    const id = req.params.id;
    const sql = "SELECT * FROM marks WHERE student_id = ?"
    con.query(sql, [id], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query Error" + err })
        return res.json({ Status: true, Result: result })
    })
})

router.get('/get_skills/:id', (req, res) => {
    const id = req.params.id;
    const sql = "SELECT * FROM basic_skills WHERE student_id = ?"
    con.query(sql, [id], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query Error" + err })
        return res.json({ Status: true, Result: result })
    })
})

router.get('/get_multiple_choice/:id', (req, res) => {
    const id = req.params.id;
    const sql = "SELECT * FROM multiple_choice WHERE student_id = ?"
    con.query(sql, [id], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query Error" + err })
        return res.json({ Status: true, Result: result })
    })
})

router.get('/get_essay/:id', (req, res) => {
    const id = req.params.id;
    const sql = "SELECT * FROM essay WHERE student_id = ?"
    con.query(sql, [id], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query Error" + err })
        return res.json({ Status: true, Result: result })
    })
})



export { router as adminRouter }