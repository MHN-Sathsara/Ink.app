const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());

const NoteSchema = new mongoose.Schema({
  id: String,
  title: String,
  content: String,
});

const Note = mongoose.model("Note", NoteSchema);

app.post("/sync", async (req, res) => {
  const { id, title, content } = req.body;
  await Note.findOneAndUpdate({ id }, { title, content }, { upsert: true });
  res.status(200).send({ message: "Note synced" });
});

app.get("/notes", async (req, res) => {
  const notes = await Note.find();
  res.json(notes);
});

mongoose
  .connect("YOUR_MONGODB_CONNECTION_STRING_HERE")
  .then(() =>
    app.listen(3000, () => console.log("Server running on port 3000")),
  );
