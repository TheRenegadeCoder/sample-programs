/**
 * First of all, we need to setup our .htaccess file. see - https://leaf-docs.netlify.app/v1.5.0/introduction/re-routing-to-index.html
 * To create a hello world project with Leaf, you simply need to initialise Leaf's Router(Leaf) 
 *
 * 
 * Leaf simply takes all requests coming into the application and handles them based on rules you define.
 *
 * You can download the leaf starter here. - https://github.com/leafsphp/leaf-starter
 */

require_once __DIR__ . "/vendor/autoload.php";

$leaf = new Leaf\Core\Leaf();

$leaf->get('/', function() {
  echo "Hello World";
});

$leaf->run();