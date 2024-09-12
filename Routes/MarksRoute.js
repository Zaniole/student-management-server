import express from 'express'
import con from '../utils/db.js'

const router = express.Router()

router.put('/update_marks/:id', (req, res) => {
    const id = req.params.id;
    const sql = `UPDATE marks 
                SET entrance_mark = ?, semester_1_mark = ?, year_mark = ?
                WHERE student_id = ?`;
    const value = [
        req.body.entrance_mark,
        req.body.semester_1_mark,
        req.body.year_mark
    ]
    con.query(sql, [...value, id], (err, result) => {
        if (err) return res.json({ Status: false, Error: "Query Error" + err })
        return res.json({ Status: true, Result: result })
    })
})

router.put('/update_essay/:id', (req,res) => {
    const id = req.params.id;
    const sql = `UPDATE essay
                SET first = ?, second = ?, third = ?, fourth = ?
                WHERE student_id = ?`;
    const value = [
        req.body.first,
        req.body.second,
        req.body.third,
        req.body.fourth
    ]
    con.query(sql, [...value, id], (err, result) => {
        if(err) return res.json({Status: false, Error: "Query Error" + err})
        return res.json({Status: true, Result: result})
    })
})

router.put('/update_multiple_choice/:id', (req,res) => {
    const id = req.params.id;
    const sql = `UPDATE multiple_choice
                SET first = ?, second = ?, third = ?, fourth = ?
                WHERE student_id = ?`;
    const value = [
        req.body.first,
        req.body.second,
        req.body.third,
        req.body.fourth
    ]
    con.query(sql, [...value, id], (err, result) => {
        if(err) return res.json({Status: false, Error: "Query Error" + err})
        return res.json({Status: true, Result: result})
    })
})

router.put('/update_basic_skills/:id', (req,res) => {
    const id = req.params.id;
    const sql = `UPDATE basic_skills
                SET listening = ?, speaking = ?, reading = ?, writing = ?
                WHERE student_id = ?`;
    const value = [
        req.body.listening,
        req.body.speaking,
        req.body.reading,
        req.body.writing
    ]
    con.query(sql, [...value, id], (err, result) => {
        if(err) return res.json({Status: false, Error: "Query Error" + err})
        return res.json({Status: true, Result: result})
    })
})

export {router as MarksRouter}