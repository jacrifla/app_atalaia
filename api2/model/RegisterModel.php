<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class RegisterModel
{
    // Insere um novo registro de usuário no banco de dados.
    public static function insert(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
            // Generates hash password
            $passwordHash = password_hash($data['password_hash'], PASSWORD_DEFAULT);
    
            $stmt = $pdo->prepare('
                INSERT INTO tb_user (uuid, name, email, phone, password_hash) 
                VALUES (UUID(), ?, ?, ?, ?)'
            );
    
            $stmt->execute([$data['name'], $data['email'], $data['phone'], $passwordHash]);
    
            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }    
}