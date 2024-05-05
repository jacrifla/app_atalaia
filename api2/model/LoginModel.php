<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class LoginModel
{
    
   

    public static function login(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
    
            $stmt = $pdo->prepare('
                SELECT uuid, name, email, phone, password_hash 
                FROM tb_user 
                WHERE (email = ? OR phone = ?) 
                    AND deleted_at IS NULL'
            );
            
            $stmt->execute([$data['email'], $data['phone']]);
    
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

    
            // Verifica se a senha fornecida condiz com o hash salvo no banco
            if (!password_verify($data['password_hash'], $user['password_hash'])) {
               return null;
            }
    
            // Retorna os dados do usuário
            unset($user['password_hash']); // Não envie o hash da senha de volta
            return $user;
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }
    

}
