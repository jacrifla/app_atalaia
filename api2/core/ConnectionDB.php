<?php

define('SGBD'       , 'mysql'       );
define('HOST'       , 'localhost'   );
define('DBNAME'     , 'atalaia'     );
define('CHARSET'    , 'utf8'        );
define('USER'       , 'root'        );
define('PASSWORD'   , ''            );
define('SERVER'     , 'windows'     );
define('PORTA_DB'   , 3306          );

class ConnectionDB
{
    private static $pdo;

    private function __construct()
    {
    }

    private static function existsExtension()
    {

        switch (SGBD):
            case 'mysql':
                $extensao = 'pdo_mysql';
                break;
        endswitch;

        if (empty($extensao) || !extension_loaded($extensao)) :
            echo "Extensão PDO '{$extensao}' não está habilitada!";
        endif;
    }

    public static function getInstance()
    {
        self::existsExtension();

        if (!isset(self::$pdo)) {

            try {
                switch (SGBD):
                    case 'mysql':
                        $opcoes = array(\PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES UTF8');
                        self::$pdo = new \PDO("mysql:host=" . HOST . "; dbname=" . DBNAME . ";", USER, PASSWORD, $opcoes);
                        break;
                    endswitch;

                self::$pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
            } catch (\PDOException $e) {
                throw new \PDOException($e->getMessage());
            } catch (\Exception $e) {
                throw new \Exception($e->getMessage());
            }
        }
        return self::$pdo;
    }

    public static function isConected()
    {

        if (self::$pdo) :
            return true;
        else :
            return false;
        endif;
    }
}

// require '../model/UserModel.php';

// $model = new UserModel();
