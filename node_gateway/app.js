require("dotenv").config();
const express = require("express")
const cors = require("cors")
const connectDB = require("./src/config/database");
const cookieParser = require("cookie-parser");

const app = express();
const PORT = process.env.PORT

app.use(cors()); 
app.use(express.json()); //every json that comes from frontend will be converted to js object. this function will work on every route.
app.use(cookieParser());

const authRouter = require("./src/routes/auth");

app.use("",authRouter);

connectDB()
    .then(()=>{
        console.log("DB connection established.");
        app.listen(PORT,()=>{
        const HOST = "localhost"; 
        console.log(`🚀 Server is running at: http://${HOST}:${PORT}`);
        });
    })
    .catch((err)=>{
        console.error(`couldn't connect to the database :( :\n ${err.message}`);
    })