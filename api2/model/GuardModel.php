<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class GuardModel
{
    public static function getSwitches($userId)
    {
        
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('SELECT s.mac_address, s.guard_active, s.name 
            FROM tb_switch s
            JOIN tb_user u ON s.user_id = u.id
            WHERE u.uuid = ?            
            AND s.deleted_at IS NULL');
            $stmt->execute([$userId]);
            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function hasGuard($userId){
        try {
            $pdo = ConnectionMYSQL::getInstance();            
            $stmt = $pdo->prepare('SELECT id from tb_guard WHERE user_id = ?');
            $stmt->execute([$userId]);

            return $stmt->fetchColumn() !== false;
        
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function createGuard($userId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();            
            $stmt = $pdo->prepare('
            INSERT INTO tb_guard (uuid, user_id) 
            VALUES (UUID(), ?)'
        );

        $stmt->bindParam(1, $userId, PDO::PARAM_STR);
        $stmt->execute();

        return $stmt->rowCount() > 0;
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Alterna a ativação do guarda com base nos dados fornecidos
    public static function toggleGuard($data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('
                UPDATE tb_guard
                SET is_active = IF(is_active = 1, 0, 1) 
                WHERE uuid = ?
            ');

            $stmt->bindParam(1, $data['guard_id'], PDO::PARAM_INT);
            $stmt->execute();

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function defineSwitches($switches, $isActive)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            
            // Sanitizar o array de switches (opcional, mas recomendado)
            $switches = array_map([$pdo, 'quote'], $switches);
            
            // Construir a cláusula IN
            $placeholders = implode(',', $switches);
            
            // Criar a consulta com os valores concatenados diretamente
            $query = "
                UPDATE tb_switch
                SET guard_active = :isActive
                WHERE mac_address IN ($placeholders)
            ";
            
            $stmt = $pdo->prepare($query);
            
            // Bind do valor para guard_active
            $stmt->bindValue(':isActive', $isActive, PDO::PARAM_INT);
            
            $stmt->execute();
            
            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }


    // public static function lastInsertId()
    // {
    //     try {
    //         $pdo = ConnectionMYSQL::getInstance();

    //         return $pdo->lastInsertId();
    //     } catch (\PDOException $e) {
    //         throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
    //     } catch (\Exception $e) {
    //         throw new \Exception($e->getMessage());
    //     }
    // }
    
}
