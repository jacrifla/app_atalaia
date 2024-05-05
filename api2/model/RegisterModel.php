<?php

require './core/ConnectionDB.php';
require './core/ExceptionPdo.php';

class RegisterModel
{

    
    public static function insert(array $data)
    {
        try {
            $pdo = ConnectionDB::getInstance();
    
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
