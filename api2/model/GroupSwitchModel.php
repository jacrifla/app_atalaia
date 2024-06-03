<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class GroupSwitchModel
{
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
    
    public static function getSwitchesInGroup($groupId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('SELECT s.* 
            FROM tb_switch s
            JOIN tb_group g ON s.group_id = g.id
            WHERE g.uuid = ?            
            AND s.deleted_at IS NULL');
            $stmt->execute([$groupId]);

            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function createGroup(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();            
            $stmt = $pdo->prepare('
            INSERT INTO tb_group (uuid, name, is_active, schedule_active, schedule_start, schedule_end, user_id, keep_for) 
            VALUES (UUID(), ?, ?, ?, ?, ?, ?, ?)'
        );

        $stmt->execute([$data['name'], $data['is_active'],$data['schedule_active'], $data['schedule_start'], $data['schedule_end'], $data['user_id'], $data['keep_for']]);

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

    public static function addSwitchToGroup(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('UPDATE tb_switch SET group_id = ? WHERE mac_address = ?');
            $stmt->execute([$data['group_id'],$data['mac_address'] ]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }

    }

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

    public static function updateGroupInfo(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

           // Prepara a query SQL para atualizar os dados do usuário
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

           // Adiciona a cláusula WHERE para especificar o usuário a ser atualizado
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

    public static function softDelete($groupId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('UPDATE tb_group SET deleted_at = CURRENT_TIMESTAMP WHERE uuid = ?');
            $stmt->execute([$groupId]);
    
            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function getGroupIdByUUID($groupId){
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
    
            $stmt = $pdo->prepare('
                SELECT id 
                FROM tb_group 
                WHERE uuid = ? 
                    AND deleted_at IS NULL'
            );
            
            $stmt->execute([$groupId]);
    
            return $stmt->fetch(PDO::FETCH_ASSOC);
    
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function removeAllSwitchesFromGroupByGroupId($groupId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            
            $stmt = $pdo->prepare('
                UPDATE tb_switch AS s
                JOIN tb_group AS g ON s.group_id = g.id
                SET s.group_id = NULL 
                WHERE g.uuid = ?
            ');
            
            $stmt->execute([$groupId]);
            
            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    
        
    public static function toggleGroup($groupId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
            $stmt = $pdo->prepare('
                UPDATE tb_group
                SET is_active = IF(is_active = 1, 0, 1)
                WHERE uuid = ?
            ');
            $stmt->bindParam(1, $groupId, PDO::PARAM_STR);
            $stmt->execute();
    
            return ($stmt->rowCount() > 0);
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


   
}
