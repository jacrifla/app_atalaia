<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require_once './PHPMailer/Exception.php';
require_once './PHPMailer/PHPMailer.php';
require_once './PHPMailer/SMTP.php';

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';
//EM CONSTRUÇÃO
class PasswordModel {


    public static function changePassword(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
            $passwordHash = password_hash($data['password_hash'], PASSWORD_DEFAULT);
    
            $sql = 'UPDATE tb_user SET password_hash = ? WHERE email = ?';
    
            // Executa a query SQL
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$passwordHash, $data['email']]);
    
            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }
    
    //Password Reset Methods
    public static function generateToken($email) {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            // $token = bin2hex(random_bytes(32 / 2));
            $token = mt_rand(100000, 999999);

            $stmt = $pdo->prepare("INSERT INTO tb_user_reset (email, token) VALUES (?, ?)");
            $stmt->execute([$email, $token]);

            return $token;
        } catch (\PDOException $e) {
            throw new \Exception($e->getMessage());
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function getTokenByEmail($email) {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare("SELECT token FROM tb_user_reset WHERE email = ?");
            $stmt->execute([$email]);
            return $stmt->fetchColumn();
        } catch (\PDOException $e) {
            throw new \Exception($e->getMessage());
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function deleteTokenByEmail($email) {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare("DELETE FROM tb_user_reset WHERE email = ?");
            $stmt->execute([$email]);
            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception($e->getMessage());
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }




    public static function sendVerificationCode($email, $code) {
        $mail = new PHPMailer(true);

        try {

              // Enviar o código por email
        // $subject = 'Código de Verificação';
        // $message = 'Seu código de verificação para redefinição de senha é: ' . $code;
        // $headers = 'From: atalaiaproject@gmail.com' . "\r\n" .
        //            'Reply-To: atalaiaproject@gmail.com' . "\r\n" .
        //            'X-Mailer: PHP/' . phpversion();

        // if (mail($email, $subject, $message, $headers)) {
        //     echo 'Código de verificação enviado!';
        // } else {
        //     echo 'Erro ao enviar o código de verificação.';
        // }
            //Configuração do servidor
            $mail->isSMTP();
            $mail->Host = 'smtp.mail.yahoo.com';
            $mail->SMTPAuth = true;
            $mail->Username = 'atalaia.project@yahoo.com';
            $mail->Password = 'Grupo1+2';
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port = 587;

            $mail->CharSet = 'UTF-8';
            $mail->Encoding = 'base64';

            // Destinatário
            $mail->setFrom('atalaia.project@yahoo.com', 'App_Atalaia');
            $mail->addAddress($email);

            // Conteúdo do email
            $mail->isHTML(true);
            $mail->Subject = 'Código de Verificação';
            $mail->Body    = 'Seu código de verificação para redefinição de senha é: ' . $code;

            $mail->send();
           echo 'Código de verificação enviado!';
        } catch (Exception $e) {
            echo "Erro ao enviar código de verificação: {$mail->ErrorInfo}";
        }
    }

}
