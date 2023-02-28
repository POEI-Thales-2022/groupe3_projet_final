package net.pblouet.ajc.incidents.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.pblouet.ajc.incidents.dao.DaoFactory;
import net.pblouet.ajc.incidents.entity.Incident;

import java.io.IOException;
import java.util.NoSuchElementException;

/**
 * Servlet implementation class IncidentDetailsServlet
 */
@WebServlet("/details")
public class IncidentDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Incident incident;
		try {
			Long id = Long.parseLong(request.getParameter("id"));
			incident = DaoFactory.get().incident().findOne(id).get();
		} catch(NumberFormatException | NoSuchElementException e) {
			response.sendRedirect("./list");
			return;
		}
		request.setAttribute("incident", incident);
		request.getRequestDispatcher("WEB-INF/details.jsp").forward(request, response);
	}

}
