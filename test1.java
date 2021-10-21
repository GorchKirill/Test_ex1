//Злостный читатель - это студент который не возвращает в срок взятые книги. Представим что срок сдачи - 30 дней,
//если студент систематически просрочивает сдачу книги, то он является самым злостным читателем.
//Для определения кандидатов на роль самого злостного читателя, понадобятся данные по дате выдачи и возврата книги,
//Нужно посчитать раницу между сроком выдачи и сроком возврата, провести сортировку по убыванию и вывести 1 результат
// это и будет ЗЛОСТНЫЙ ЧИТАТЕЛЬ.




import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.*;


public class test {


    public  class JdbcExceptionDemo {
        static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
        static final String DATABASE_URL = "jdbc:mysql://localhost:3306/Library";
        static final String USER = "root";
        static final String PASSWORD = "password";
    }
        public static void main(String[] args) {
            Connection connection = null;

            try {
                Class.forName(JdbcExceptionDemo.JDBC_DRIVER);
                //Подключение к базе данных
                connection = DriverManager.getConnection(JdbcExceptionDemo.DATABASE_URL, JdbcExceptionDemo.USER, JdbcExceptionDemo.PASSWORD);
                //Добавление SQL запроса
                Statement statement = connection.createStatement();
                String SQL = "select Name_student, count(issue_book.id) as Count  from student join issue_book on student.id = issue_book.student_id where issue_book.date_of_issue between '2020-01-01' and '2021-01-01' group by Name_Student having sum(date_of_return - date_of_issue)>30  order by count(Name_student) desc limit 1";
                ResultSet resultSet = statement.executeQuery(SQL);

                //вывод результата SQL запроса
                while (resultSet.next()) {
                    String Name_Student = resultSet.getString("Name_Student");
                    int Count = resultSet.getInt("Count");

                    System.out.println("\nЗлостный читатель:");
                    System.out.println("Имя Студента: " + Name_Student);
                    System.out.println("Количетсво опозданий по срокам сдачи: " + Count);
                }

                resultSet.close();
                statement.close();
                connection.close();
            //Обработка исключений
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }



