<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class GroupSwitchModel
{
    // Obtém os grupos do usuário com base no ID do usuário
    public static function getGroups($userId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('SELECT g.uuid 
            FROM tb_group g
            JOIN tb_user u ON g.user_id = u.id
            WHERE u.uuid = ?            
            AND g.deleted_at IS NULL');
            $stmt->execute([$userId]);

            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Obtém todas as informações de um grupo com base no ID do usuário
    public static function getAllGroupInfo($userId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('SELECT g.uuid, g.name, g.is_active, g.schedule_active, g.schedule_start, g.schedule_end 
            FROM tb_group g
            JOIN tb_user u ON g.user_id = u.id
            WHERE u.uuid = ?            
            AND g.deleted_at IS NULL');
            $stmt->execute([$userId]);

            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Obtém informações de um grupo com base no ID do grupo
    public static function getOneGroup($groupId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('SELECT * 
            FROM tb_group 
            WHERE uuid = ?            
            AND deleted_at IS NULL');
            $stmt->execute([$groupId]);

            return $stmt->fetch(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Cria um novo grupo com base nos dados fornecidos
    public static function createGroup(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();            
            $stmt = $pdo->prepare('
            INSERT INTO tb_group (uuid, name, is_active, schedule_active, schedule_start, schedule_end, user_id) 
            VALUES (UUID(), ?, ?, ?, ?, ?, ?)'
        );

        $stmt->execute([
            $data['name'], 
            $data['is_active'],
            $data['schedule_active'], 
            $data['schedule_start'], 
            $data['schedule_end'], 
            $data['user_id']
        ]);

        if ($stmt->rowCount() > 0) {
            // Recupera o último ID inserido
            $lastId = $pdo->lastInsertId();

            // Busca os dados recém-inseridos
            $stmt = $pdo->prepare('SELECT uuid FROM tb_group WHERE id = ?');
            $stmt->execute([$lastId]);

            $insertedData = $stmt->fetch(PDO::FETCH_ASSOC);

            return $insertedData;
        } else {
            return false;
        }
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Atualiza as informações de um grupo com base nos dados fornecidos
    public static function updateGroupInfo(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

           // Prepara a query SQL para atualizar os dados do grupo
           $sql = 'UPDATE tb_group SET ';

           // Monta a string SQL com os campos a serem atualizados e prepara os parâmetros
           $params = [];
           $fields = ['name', 'is_active', 'schedule_active' , 'schedule_start', 'schedule_end'];
           foreach ($fields as $field) {
               if (isset($data[$field])) {
                   $sql .= "$field = :$field, ";
                   $params[":$field"] = $data[$field];
               }
           }

           // Remove a última vírgula e espaço da string SQL
           $sql = rtrim($sql, ', ');

           // Adiciona a cláusula WHERE para especificar o grupo a ser atualizado
           $sql .= ' WHERE uuid = :uuid';
           $params[':uuid'] = $data['group_id'];

           // Executa a query SQL
           $stmt = $pdo->prepare($sql);
           $stmt->execute($params);


            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Alterna a ativação de um grupo com base nos dados fornecidos
    public static function toggleGroup($data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('
                UPDATE tb_group
                SET is_active = ?
                WHERE id = ?
            ');
            $stmt->bindParam(1, $data['is_active'], PDO::PARAM_INT);
            $stmt->bindParam(2, $data['group_id'], PDO::PARAM_INT);
            $stmt->execute();

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Alterna os switches de um grupo com base nos dados fornecidos
    public static function toggleSwitches($groupId, $isActive)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('
                UPDATE tb_switch
                SET is_active = ?
                WHERE group_id = ?
            ');
            $stmt->bindParam(1, $isActive, PDO::PARAM_INT);
            $stmt->bindParam(2, $groupId, PDO::PARAM_INT);
            $stmt->execute();

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Adiciona um switch a um grupo com base no ID do grupo e no endereço MAC do switch
    public static function addSwitchToGroup($groupId, $mac_address)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('UPDATE tb_switch SET group_id = ? WHERE mac_address = ?');
            $stmt->execute([$groupId, $mac_address]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Obtém os switches em um grupo com base no ID do grupo
    public static function getSwitchesInGroup($groupId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('SELECT * 
            FROM tb_switch
            WHERE group_id = ?            
            AND deleted_at IS NULL');
            $stmt->execute([$groupId]);

            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Verifica se um switch está em um grupo com base no endereço MAC
    public static function checkSwitchInGroup($mac_address)
    {
        try{
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('SELECT group_id FROM tb_switch WHERE mac_address = ? AND group_id IS NOT NULL');
            $stmt->execute([$mac_address]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }

    }

    // Remove um switch de um grupo com base no endereço MAC
    public static function removeSwitchFromGroup($mac_address)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('UPDATE tb_switch SET group_id = NULL WHERE mac_address = ?');
            $stmt->execute([$mac_address]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }

    }

    // Remove logicamente um grupo com base no ID do grupo
    public static function softDelete($groupId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('UPDATE tb_group SET deleted_at = CURRENT_TIMESTAMP WHERE uuid = ? AND deleted_at IS NULL');
            $stmt->execute([$groupId]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Remove todos os switches de um grupo com base no ID do grupo
    public static function removeAllSwitchesFromGroup($groupId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            // Preparar a consulta SQL
            $sql = "UPDATE tb_switch SET group_id = NULL WHERE group_id = ?";
            $stmt = $pdo->prepare($sql);
    
            $stmt->execute([$groupId]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    // Obtém o ID do grupo com base no UUID do grupo
    public static function getGroupIdByUUID($groupId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
    
            $stmt = $pdo->prepare('
                SELECT id 
                FROM tb_group 
                WHERE uuid = ? '
            );
            
            $stmt->execute([$groupId]);
    
            return $stmt->fetch(PDO::FETCH_ASSOC);
    
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

   
    



//     public static function insertGroupInfo(array $data)
// {
//     try {
//         $pdo = ConnectionMYSQL::getInstance();

//         // Lista dos campos permitidos
//         $fields = ['uuid', 'name', 'is_active', 'schedule_active', 'schedule_start', 'schedule_end'];

//         // Monta a string SQL com os campos a serem inseridos e prepara os parâmetros
//         $columns = [];
//         $placeholders = [];
//         $params = [];
//         foreach ($fields as $field) {
//             if (isset($data[$field])) {
//                 $columns[] = $field;
//                 $placeholders[] = ":$field";
//                 $params[":$field"] = $data[$field];
//             }
//         }

//         // Concatena os campos e os placeholders para formar a query SQL
//         $sql = sprintf(
//             'INSERT INTO tb_group (%s) VALUES (%s)',
//             implode(', ', $columns),
//             implode(', ', $placeholders)
//         );

//         // Executa a query SQL
//         $stmt = $pdo->prepare($sql);
//         $stmt->execute($params);

//         // Verifica se a inserção foi bem-sucedida
//         return ($stmt->rowCount() > 0);
//     } catch (\PDOException $e) {
//         throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
//     } catch (\Exception $e) {
//         throw new \Exception($e->getMessage());
//     }
// }

// public static function removeAllSwitchesFromGroup(array $mac_addresses)
//     {
//         try {

//             // var_dump("mac_addresses" , $mac_addresses);
//             $pdo = ConnectionMYSQL::getInstance();

//             // Construir a cláusula IN com placeholders
//             $placeholders = implode(',', array_fill(0, count($mac_addresses), '?'));
    
//             // Preparar a consulta SQL
//             $sql = "UPDATE tb_switch SET group_id = NULL WHERE mac_address IN ($placeholders)";
//             $stmt = $pdo->prepare($sql);
    
//             // Executar a consulta com a lista de mac_addresses
//             $stmt->execute($mac_addresses);

//             return ($stmt->rowCount() > 0);
//         } catch (\PDOException $e) {
//             throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
//         } catch (\Exception $e) {
//             throw new \Exception($e->getMessage());
//         }

//     }
}