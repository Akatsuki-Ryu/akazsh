--  some more customzed prompts
require("gen").prompts["Elaborate_Text_akabox_test"] = {
    prompt = "Elaborate the following text:\n$text",
    replace = true,
}
require("gen").prompts["Fix_Code_akabox_test"] = {
    prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
    replace = true,
    extract = "```$filetype\n(.-)```",
}
