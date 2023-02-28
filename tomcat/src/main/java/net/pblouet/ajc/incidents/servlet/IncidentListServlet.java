package net.pblouet.ajc.incidents.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.pblouet.ajc.incidents.dao.DaoFactory;
import net.pblouet.ajc.incidents.entity.Incident;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class Incidents
 */
@WebServlet("/list")
public class IncidentListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Incident> incidents = DaoFactory.get().incident().findAll();
		request.setAttribute("incidents", incidents);
		request.getRequestDispatcher("WEB-INF/list.jsp").forward(request, response);
	}

	public static String cssSeverity(Incident incident) {
		return switch (incident.getSeverity()) {
		case CRITICAL -> "bg-critical";
		case ERROR -> "bg-error";
		case MEDIUM -> "bg-medium";
		case MINOR -> "bg-minor";
		};
	}

}
