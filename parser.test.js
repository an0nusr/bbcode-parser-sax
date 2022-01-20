const { parse } = require("./bbcode-parser")

test("check basic text parses without tags", () => {
    let res = parse("I am text")
    expect(res.length).toBe(1)
    expect(res[0].type).toBe("text")
    expect(res[0].text).toBe("I am text")
})

test("check basic tag functionality", () => {
    let res = parse("[b]bold![/b]")
    expect(res.length).toBe(3)
    expect(res[0].type).toBe("startTag")
    expect(res[0].tag.name).toBe("b")
    expect(res[1].type).toBe("text")
    expect(res[2].type).toBe("endTag")
    expect(res[2].tag.name).toBe("b")
})

test("check tag attributes", () => {
    let res = parse("[url=https://site.com?q=1]")
    expect(res.length).toBe(1)
    expect(res[0].type).toBe("startTag")
    
    let tag = res[0].tag
    expect(tag.name).toBe("url")
    expect(tag.value).toBe("https://site.com?q=1")
})