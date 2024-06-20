<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class SwitchModel
{
    // devolve todos os switches com base no uuid
    public static function getSwitches($userId)
    {
        
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('SELECT s.* 
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

    // Devolve os switches que nao estao no mesmo grupo
    public static function getSwitchesWithoutGroup($userId)
    {
        
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('SELECT s.* 
            FROM tb_switch s
            JOIN tb_user u ON s.user_id = u.id
            WHERE u.uuid = ?
            AND s.group_id IS NULL
            AND s.deleted_at IS NULL');
            $stmt->execute([$userId]);
            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Devolve is_active ta ligado ou desligado
    public static function getSwitch($mac_address)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare("
            SELECT 
                s.updated_at as updated_at,
                s.is_active as is_active,
                s.guard_active as guard_active,
                CAST(COALESCE(g.is_active, 0) as UNSIGNED) as guard_is_on,
                COALESCE(g.updated_at, '1970-01-01 00:00:00') AS guard_updated_at
            FROM tb_switch s
            INNER JOIN tb_user u ON u.id = s.user_id
            LEFT JOIN tb_guard g ON g.user_id = u.id
            WHERE s.mac_address = ?");
            $stmt->execute([$mac_address]);

            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }
    
    //Atualiza se o switch ta aceso ou apagado
    public static function toggleSwitch($data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('UPDATE tb_switch SET is_active = IF(is_active = 1, 0, 1) WHERE mac_address = ?');
            // $stmt->bindParam(1, $data['is_active'], PDO::PARAM_INT); // Alterado para garantir que o PDO converta corretamente para BIT
            $stmt->bindParam(1, $data['mac_address'], PDO::PARAM_STR);
            $stmt->execute();

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Verifica se um switch se esta vinculado a um usuario
    public static function checkSwitchExists($data){
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
    
            $stmt = $pdo->prepare('
                SELECT s.id 
                FROM tb_switch s
            JOIN tb_user u ON s.user_id = u.id
            WHERE u.id = ?  AND s.mac_address = ? '
            );
            
            $stmt->execute([$data['user_id'],$data['mac_address']]);
    
            return $stmt->fetch(PDO::FETCH_ASSOC);
    
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Cria um switch no banco de dados
    public static function createSwitch(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('
            INSERT INTO tb_switch (uuid, name, watts, mac_address, user_id) 
            VALUES (UUID(), ?, ?, ?, ?)'
        );

        $stmt->execute([$data['name'], $data['watts'], $data['mac_address'], $data['user_id']]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Caso tente criar um switch novamente após ter deletado (softdelete) 
    public static function reactivateSwitch(array $data){
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('UPDATE tb_switch SET name = ?, watts = ?, deleted_at = NULL WHERE mac_address = ?');
            $stmt->execute([$data['name'], $data['watts'], $data['mac_address']]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Edita nome, watts de um switch
    public static function updateSwitchInfo(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('UPDATE tb_switch SET name = ?, watts = ? WHERE mac_address = ?');
            $stmt->execute([$data['name'], $data['watts'], $data['mac_address']]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // faz um soft delete no switch
    public static function softDelete($mac_address)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('UPDATE tb_switch SET deleted_at = CURRENT_TIMESTAMP WHERE mac_address = ?');
            $stmt->execute([$mac_address]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

   
}