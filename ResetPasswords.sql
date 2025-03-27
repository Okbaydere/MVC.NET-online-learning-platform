-- Kullanıcı şifrelerini sıfırlama scripti
-- Test123! şifresi için hash değeri
DECLARE @NewPasswordHash NVARCHAR(MAX) = 'AQAAAAIAAYagAAAAEHJpZeaa/6Smpo+37ZyB6QBFTVry/yYOEaB1iFdNF/woJUSTNM7yHzEdmJQCM3R5Mg=='

-- Tüm kullanıcıların şifrelerini güncelle
UPDATE AspNetUsers 
SET PasswordHash = @NewPasswordHash
WHERE Email IN (
    'instructor1@example.com',
    'student1@example.com',
    'admin@example.com'
)

-- Güncelleme sonrası kullanıcıları listele
SELECT Email, UserName, PasswordHash 
FROM AspNetUsers 
WHERE Email IN (
    'instructor1@example.com',
    'student1@example.com',
    'admin@example.com'
) 