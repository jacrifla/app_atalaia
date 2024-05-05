<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class PasswordModel {


    public static function changePassword(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
            // Prepara a query SQL para atualizar o campo deleted_at // Generates hash password
            $passwordHash = password_hash($data['password_hash'], PASSWORD_DEFAULT);
    
            $sql = 'UPDATE tb_user SET password_hash = ? WHERE id = ?';
    
            // Executa a query SQL
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$passwordHash, $data['id']]);
    
            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }
    
    //Password Reset Methods
    public static function generateToken(array $data) {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $email = $data['email'];
            $token = $data['token'];
            $expiration = $data['expiration'];

            $stmt = $pdo->prepare("INSERT INTO tb_user_reset (email, token, date_expiration) VALUES (?, ?, ?)");
            $stmt->execute([$email, $token, $expiration]);
        } catch (\PDOException $e) {
            throw new \Exception($e->getMessage());
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function getTokenByEmail(array $data) {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $email = $data['email'];

            $stmt = $pdo->prepare("SELECT * FROM tb_user_reset WHERE email = ?");
            $stmt->execute([$email]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            throw new \Exception($e->getMessage());
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function deleteTokenByEmail(array $data) {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $email = $data['email'];

            $stmt = $pdo->prepare("DELETE FROM tb_user_reset WHERE email = ?");
            $stmt->execute([$email]);
        } catch (\PDOException $e) {
            throw new \Exception($e->getMessage());
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }
}
