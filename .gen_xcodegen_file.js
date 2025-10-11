const { Liquid } = require('liquidjs');
const fs = require('fs');
const dotenv = require('dotenv');

dotenv.config({ path: '.envrc' });

async function xcodegenTemplate(filepath) {
    return new Promise((resolve, reject) => {
        try {
            fs.readFile(filepath, "utf-8", (err, data) => {
                if (err) reject(err);
                resolve(data);
            });
        } catch (err) {
            reject(err)
        }
    });
}

const parsedContent = (template, parameters) => {
    var engine = new Liquid();
    return engine.parseAndRender(template, parameters);
}

const generateFile = (filepath, content) => {
    return new Promise((resolve, reject) => {
        fs.writeFile(filepath, content, function (err) {
            if (err) throw reject(err);
            resolve()
        }); 
    });
};

async function main() {
    const template = await xcodegenTemplate("project.yml.liquid");
    const rendered = await parsedContent(template, process.env)
    await generateFile("project.yml", rendered)
}

main().catch(console.error)
