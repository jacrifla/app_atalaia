<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class GuardModel
{
    //Obtém os switches associados a um usuário específico.
    public static function getSwitches($userId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('
                SELECT s.mac_address, s.guard_active, s.name AS switch_name, g.is_active as guard_is_on, g.uuid AS guard_id 
                FROM tb_switch s
                INNER JOIN tb_user u ON u.id = s.user_id
                LEFT JOIN tb_guard g ON g.user_id = u.id           
                WHERE u.id = :userId AND s.deleted_at IS NULL
            ');

            // Bind do valor userId ao placeholder :userId
            $stmt->bindValue(':userId', $userId, PDO::PARAM_INT);

            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }


    // Verifica se um usuário possui um guarda.
    public static function hasGuard($userId)
    {
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

    // Cria um novo guarda para um usuário específico.
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

    // Alterna o estado de ativação de um guarda.
    public static function toggleGuard($guardId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('
                UPDATE tb_guard
                SET is_active = IF(is_active = 1, 0, 1) 
                WHERE uuid = ?
            ');

            $stmt->bindParam(1, $guardId, PDO::PARAM_STR);
            $stmt->execute();

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Define o estado de ativação dos switches com base em seus endereços MAC.
    public static function defineSwitch($mac_address, $isActive)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            
           
            // Criar a consulta com os valores concatenados diretamente
            $query = "
                UPDATE tb_switch
                SET guard_active = :isActive
                WHERE mac_address =:mac_address
            ";
            
            $stmt = $pdo->prepare($query);
            
            // Bind do valor para guard_active
            $stmt->bindValue(':isActive', $isActive, PDO::PARAM_INT);
            $stmt->bindValue(':mac_address', $mac_address, PDO::PARAM_STR);
            
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