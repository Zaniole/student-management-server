import express from "express";
import cors from 'cors';
import { adminRouter } from "./Routes/AdminRoute.js";
import { MarksRouter } from "./Routes/MarksRoute.js";
import Jwt from "jsonwebtoken";
import cookieParser from "cookie-parser";

const app = express()

app.use(cors({
    origin: ["http://localhost:6969"],
    methods: ['GET', 'POST', 'PUT','DELETE'],
    credentials: true
}))

app.use(express.json());
app.use(cookieParser())
app.use('/auth', adminRouter);
app.use('/auth', MarksRouter);

const verifyUser = (req, res, next) => {
    const token = req.cookies.token;
    if(token) {
        Jwt.verify(token, "secret_web_token", (err, decoded) => {
            if(err) return res.json({Status: false, Error: "Wrong Token"})
            req.username = decoded.username;
            //req.role = decoded.role;
            next()
        })
    } else {
        return res.json({Status: false, Error: "Not autheticated"})
    }
}
app.get('/verify', verifyUser, (req, res)=> {
    return res.json({Status: true, role: req.role, id: req.id})
} )

app.listen(3000, () => {
    console.log("Server is running")
})