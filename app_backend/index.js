const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const Note = require("./models/Note");

const app = express();
app.use(express.json()); // Allows the app to read JSON data
app.use(cors()); // Allows Flutter to talk to this server

// 1. CREATE (POST)
app.post("/notes", async (req, res) => {
  const newNote = new Note(req.body);
  await newNote.save();
  res.json(newNote);
});

// 2. READ (GET)
app.get("/notes", async (req, res) => {
  const notes = await Note.find();
  res.json(notes);
});

// 3. UPDATE (PUT)
app.put("/notes/:id", async (req, res) => {
  const updatedNote = await Note.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
  });
  res.json(updatedNote);
});

// 4. DELETE (DELETE)
app.delete("/notes/:id", async (req, res) => {
  await Note.findByIdAndDelete(req.params.id);
  res.json({ message: "Note deleted" });
});

// Connect to MongoDB
mongoose
  .connect("YOUR_MONGODB_CONNECTION_STRING_HERE")
  .then(() =>
    app.listen(3000, () => console.log("Server running on port 3000")),
  );
