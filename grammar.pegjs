// Simple BBCode Parser in PEG
// ==========================
//
// Produces SAX-style events based on what is parsed.
// Can be reviewed and tested at https://pegjs.org/online

Expression
  = (EndTag / StartTag / String)*
  
TagChars
  = !("]" / " ") name:(. TagChars*) { return name.join("") }
  
TagCharsWithoutEquals
  = !("]" / " " / "=") name:(. TagCharsWithoutEquals*) { return name.join("") }
  
Tag
  = name:(TagChars) { return  {"name": name, value: null } }
  
TagWithValue
  = name:(TagCharsWithoutEquals) "=" value:(TagChars) { return { name: name, value: value } }
 
StartTag
  = "[" tagName:(TagWithValue / Tag) "]" {return {type: "startTag", tag: tagName} }
 
EndTag
  = "[/" tagName:(TagWithValue / Tag) "]" {return {type: "endTag", tag: tagName} }
 
NotTag
  = !(EndTag / StartTag) s:(. NotTag*) { return s.join("") }
  
String
  = s:NotTag { return {type: "text", text: s} }