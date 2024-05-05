<?php

require './core/ConnectionDB.php';
require './core/ExceptionPdo.php';

class RegisterModel
{
    public static function show()
    {
        try {
            $pdo = ConnectionDB::getInstance();

            $stmt = $pdo->prepare('SELECT * FROM tb_user');
            $stmt->execute();

            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function find(int $codigo)
    {
        try {
            $pdo = ConnectionDB::getInstance();

            $stmt = $pdo->prepare('SELECT * from tb_produto WHERE codigo = ?');
            $stmt->execute([$codigo]);

            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function login(string $email, string $phone, string $hashedPassword)
{
    try {
        $pdo = ConnectionDB::getInstance();

        $stmt = $pdo->prepare('
            SELECT id, name, email, phone, password_hash 
            FROM tb_user 
            WHERE (email = ? OR phone = ?) 
                AND deleted_at IS NULL'
        );
        
        $stmt->execute([$email, $phone]);

        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            return null;
        }

        // Verifica se a senha fornecida condiz com o hash salvo no banco
        if (!password_verify($hashedPassword, $user['password_hash'])) {
            throw new \Exception('Senha incorreta');
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


    public static function insert(array $data)
    {
        try {
            $pdo = ConnectionDB::getInstance();

            $stmt = $pdo->prepare('INSERT INTO tb_produto (descricao, valor) VALUES(?, ?)');
            $stmt->execute([$data['descricao'], $data['valor']]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function update(array $data)
    {
        try {
            $pdo = ConnectionDB::getInstance();

            $stmt = $pdo->prepare('UPDATE tb_produto SET descricao = ?, valor = ? WHERE codigo = ?');
            $stmt->execute([$data['descricao'], $data['valor'], $data['codigo']]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function delete(int $codigo)
    {
        try {
            $pdo = ConnectionDB::getInstance();

            $stmt = $pdo->prepare('DELETE FROM tb_produto WHERE codigo = ?');
            $stmt->execute([$codigo]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function lastInsertId()
    {
        try {
            $pdo = ConnectionDB::getInstance();

            return $pdo->lastInsertId();
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }
}
