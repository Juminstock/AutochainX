use std::fs;

fn hn(text: &str, n: usize) -> String {

    let formated = format!("<h{}>{}</h{}>", n, text, n);
    return formated;
}

fn main() {

    let user_input = "prueba.md";
    // get_md();
    let file = fs::read_to_string(user_input);
    let mut lines = Vec::new();

    match file {
        Ok(contents) => {
            let item = contents.split('\n');
            for line in item {
                lines.push(line.to_string());
            }
            for i in &lines {
                let mut iter = i.chars();
                let num_hashes = iter.clone().take_while(|&c| c == '#').count();
                iter.nth(num_hashes);
                let text: String = iter.collect::<String>().trim().to_owned();

                let html = hn(text.trim(), num_hashes);
                println!("{:?}", html);
            }
        }
        Err(error) => {
            println!("Error al leer el archivo: {}", error);
        }
    }
}