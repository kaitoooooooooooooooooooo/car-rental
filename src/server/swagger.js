import YAML from "yamljs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const swaggerDocument = YAML.load(path.join(__dirname, "swagger.yaml"));

export default swaggerDocument;
