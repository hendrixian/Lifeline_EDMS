package JavaFiles;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
@WebServlet(name = "Shelter_and_Areas", urlPatterns = {"/Shelter_and_Areas"})
public class DataServlet extends HttpServlet {


	public DataServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Handle API request
		try {
			Connection connection = null;
			try
			{
				Class.forName("org.mariadb.jdbc.Driver");
			}
			catch(ClassNotFoundException e)
			{
				e.printStackTrace();
			}
			try
			{
				connection=DriverManager.getConnection("jdbc:mariadb://localhost:3306/edms" , "root","");
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			String query = "SELECT * FROM representative order by TotalPriority desc";

			Statement stmt;
			ArrayList<String>Verified1=new ArrayList();
			ArrayList<String>Name1=new ArrayList();
			ArrayList<String>Type1=new ArrayList();
			ArrayList<String>Activity1=new ArrayList();
			ArrayList<String> Division1 =new ArrayList();
			ArrayList<String> City1 =new ArrayList();
			ArrayList<String> Township1 =new ArrayList();
			ArrayList<String>Username1=new ArrayList();
			try
			{
				stmt = connection.createStatement();
				ResultSet rs = stmt.executeQuery(query);
				while(rs.next())
				{
					String name = rs.getString("sheltername");
					String type = rs.getString("type");
					String activ = rs.getString("activity");
					String LocUser = rs.getString("Zipcode");

					/**
					String dist = rs.getString("District");
					String upa = rs.getString("Upazilla");
					String uni = rs.getString("Unionn");
					**/
                    String user= rs.getString("Representativename");


					String Div = null;
					String City = null;
					String Township = null;

					String query2 = "SELECT * FROM myanmar where Zipcode = '"+LocUser+"'";
					try
					{
						Statement stmt2 = connection.createStatement();

						ResultSet rs2 = stmt2.executeQuery(query2);

						while(rs2.next())
						{
							Div = rs2.getString("Divisions");
							City = rs2.getString("Cities");
							Township = rs2.getString("Townships");
						}

					}
					catch(Exception e)
					{

					}



					Verified1.add(Div);
					Name1.add(name);
					Type1.add(type);
					Activity1.add(activ);
                    Username1.add(user);
					Division1.add(Div);
					City1.add(City);
					Township1.add(Township);
					//System.out.println("none"+Activity1.size());

				}


			}
			catch(Exception e)
			{

			}
			List<List<String>> mergedList = new ArrayList<>();
			mergedList.add(Verified1);
			mergedList.add(Name1);
			mergedList.add(Type1);
			mergedList.add(Activity1);
			mergedList.add(Division1);
			mergedList.add(City1);
			mergedList.add(Township1);
			mergedList.add(Username1);
			// Convert the data to JSON
			ObjectMapper objectMapper = new ObjectMapper();
			try {
				String json = objectMapper.writeValueAsString(mergedList);

				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(json);
			} catch (Exception e) {
				e.printStackTrace();
			}


		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(500);
		}

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}