-- Criando o banco de dados
CREATE DATABASE db_atalaia
	CHARACTER SET utf8mb4
	COLLATE utf8mb4_unicode_ci;

-- Selecionando o banco de dados
use db_atalaia;

-- DROP DATABASE db_atalaia;

-- Criando a tabela de usuários
CREATE TABLE tb_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(36) NOT NULL, -- Id que é mostrado através da API. Usar a função UUID() do MySQL para preencher esse dado
    name VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL, -- Único (ver constraint)
    phone VARCHAR(15) NOT NULL, -- Único (ver constraint)
    password_hash VARCHAR(100) NOT NULL, -- Guardar apenas o hash (sugestão - usar a biblioteca bcrypt para php)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Marcado automaticamente na criação do dado
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP, -- Muda automaticamente toda vez que o dado sofre uma auteração
    deleted_at TIMESTAMP NULL, -- Usado para fazer soft-delete. Será necessário que todas as queries tenham WHERE deleted_at IS NULL
    INDEX IX_tb_user_uuid (uuid),
    CONSTRAINT UQ_tb_user_email UNIQUE (email),
    CONSTRAINT UQ_tb_user_phone UNIQUE (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Criando a tabela de grupos
CREATE TABLE tb_group (
    id INT AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(36) NOT NULL,
    user_id INT NOT NULL,
	icon_name VARCHAR(17) NOT NULL,
    -- sort_order SMALLINT UNSIGNED NOT NULL, -- Usado para ordenar na tela do usuário (Melhoria)
    name VARCHAR(100) NOT NULL,
    is_priority BIT NOT NULL DEFAULT 0, -- Diz se o grupo tem prioridade sobre outros grupos e sobre o keep_active dos interruptores
    is_active BIT NOT NULL DEFAULT 1, -- Diz se o grupo está ligado ou desligado
    last_time_active TIMESTAMP NULL, -- Sempre que o is_active muda para 1 ele deverá marcar a data e a hora, sempre que mudar para 0 ele deverá marcar NULL (isso será usado na tabela de monitoramento)
    keep_active BIT NOT NULL DEFAULT 0, -- Se marcado ele irá manter o grupo ligado pelo tempo definido no keep_for (OBS não pode ocorrer junto com o schedule_active)
	keep_for TIME NOT NULL DEFAULT '01:00:00',
    schedule_active BIT NOT NULL DEFAULT 0, -- Se marcado o grupo deverá ser ativado/desativado nos horários definidos em schedule_start/schedule_end (OBS não pode ocorrer junto com o keep_active)
    schedule_last_activation DATE NULL, -- Serve para verificar se a ativação do schedule já foi feita naquele dia, caso sim ele não ativa o interruptor novamente. Isso dá liberdade para o usuário desligar a lâmpada dentro do horário do schedule. 
    schedule_start TIME NOT NULL DEFAULT '18:30:00',
    schedule_end TIME NOT NULL DEFAULT '22:00:00',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    INDEX IX_tb_group_uuid (uuid),
	CONSTRAINT FK_tb_group_user_id FOREIGN KEY (user_id) REFERENCES tb_user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Criando a tabela de interruptores switch
CREATE TABLE tb_switch (
    id INT AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(36) NOT NULL,
    user_id INT NOT NULL,
	icon_name VARCHAR(17) NOT NULL,
    group_id INT,
    -- sort_order SMALLINT UNSIGNED NOT NULL, -- Usado para ordenar na tela do usuário (Melhoria)
    mac_address VARCHAR(17) NOT NULL, -- Único (ver constraint)
    name VARCHAR(100) NOT NULL,
    is_active BIT NOT NULL DEFAULT 1, -- Diz se o interruptor está ligado ou desligado
    last_time_active TIMESTAMP NULL, -- Sempre que o is_active muda para 1 ele deverá marcar a data e a hora, sempre que mudar para 0 ele deverá marcar NULL (isso será usado na tabela de monitoramento)
    watts SMALLINT UNSIGNED NOT NULL DEFAULT 0, -- Usado para calcular o consumo
    keep_active BIT NOT NULL DEFAULT 1, -- Se marcado o interruptor não irá desligar quando o grupo que o ativou for desligado (só pode ser desligado pelo comando do switch em si ou manualmente)
    schedule_active BIT NOT NULL DEFAULT 0, -- Se marcado o interruptor deverá ser ativado/desativado nos horários definidos em schedule_start/schedule_end
    schedule_last_activation DATE NULL, -- Serve para verificar se a ativação do schedule já foi feita naquele dia, caso sim ele não ativa o interruptor novamente. Isso dá liberdade para o usuário desligar a lâmpada dentro do horário do schedule. 
    schedule_start TIME NOT NULL DEFAULT '18:30:00', --  Exemplo de quando deve ser ativado o ponto: WHERE schedule_active = 1 AND schedule_last_activation <> CURRENT_DATE() AND (CURRENT_TIME() BETWEEN schedule_start AND schedule_end)
    schedule_end TIME NOT NULL DEFAULT '22:00:00',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    guard_active BIT NOT NULL DEFAULT 0, -- Diz se o interruptor está ligado ou desligado no modo guarda
    INDEX IX_tb_switch_uuid (uuid),
	CONSTRAINT FK_tb_switch_user_id FOREIGN KEY (user_id) REFERENCES tb_user(id),
    CONSTRAINT FK_tb_switch_group_id FOREIGN KEY (group_id) REFERENCES tb_group(id),
    CONSTRAINT UQ_tb_switch_mac_address UNIQUE (mac_address)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tb_guard (
    id INT AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(36) NOT NULL,
    user_id INT NOT NULL,
    deleted_at TIMESTAMP NULL,
    is_active BIT NOT NULL DEFAULT 0, -- Quando ativo toda a funcionalidade deve parar
    INDEX IX_tb_guard_uuid (uuid),
	CONSTRAINT FK_tb_guard_user_id FOREIGN KEY (user_id) REFERENCES tb_user(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tb_user_reset (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(40) NOT NULL,
    token VARCHAR(100) NOT NULL,
    date_expiration TIMESTAMP NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tb_mac_addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mac_address VARCHAR(17) NOT NULL,
    is_used BIT NOT NULL DEFAULT 0,
    CONSTRAINT UQ_tb_mac_address UNIQUE (mac_address)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
