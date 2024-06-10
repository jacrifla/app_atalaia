<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class UserModel
{
    // Puxa todos os usuários
    public static function getAllUsers()
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('
                SELECT name, email, phone, uuid
                FROM tb_user
                WHERE deleted_at IS NULL
            ');
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Retorna o id do usuario com base no uuid
    public static function getUserByUUID($userId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('
                SELECT id 
                FROM tb_user 
                WHERE uuid = ? 
                AND deleted_at IS NULL
            ');
            $stmt->execute([$userId]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Retorna o id do usuario com base no email
    public static function checkUserExists(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('
                SELECT id 
                FROM tb_user 
                WHERE email = ? 
                AND deleted_at IS NULL
            ');
            $stmt->execute([$data['email']]);
            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Faz um update no na tabela de usuario, com base no uuid(user_id)
    public static function updateUserInfo(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $sql = 'UPDATE tb_user SET ';

            $params = [];
            $fields = ['name', 'email', 'phone'];
            foreach ($fields as $field) {
                if (isset($data[$field])) {
                    $sql .= "$field = :$field, ";
                    $params[":$field"] = $data[$field];
                }
            }

            $sql = rtrim($sql, ', ');
            $sql .= ' WHERE uuid = :uuid';
            $params[':uuid'] = $data['user_id'];

            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Faz um soft delete na tabela usuarios e coloca a data da deleção
    public static function softDelete($userId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $sql = 'UPDATE tb_user SET deleted_at = CURRENT_TIMESTAMP WHERE uuid = ?';

            $stmt = $pdo->prepare($sql);
            $stmt->execute([$userId]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Puxa o nome, email e telefone do usuario com base no uuid
    public static function getUserInfo($userId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('
                SELECT name, email, phone
                FROM tb_user 
                WHERE uuid = ?  
                AND deleted_at IS NULL
            ');
            $stmt->execute([$userId]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }
}