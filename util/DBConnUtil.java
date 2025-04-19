
package util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnUtil {
    public static Connection getConnection(String url, String user, String pass) {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(url, user, pass);
        } catch (Exception e) {
            System.out.println("Connection failed: " + e.getMessage());
        }
        return conn;
    }
}
