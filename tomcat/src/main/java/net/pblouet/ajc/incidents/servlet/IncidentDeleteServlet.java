package net.pblouet.ajc.incidents.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.pblouet.ajc.incidents.dao.DaoFactory;

import java.io.IOException;

/**
 * Servlet implementation class IncidentDeleteServlet
 */
@WebServlet("/remove")
public class IncidentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Long id = Long.parseLong(request.getParameter("id"));
			DaoFactory.get().incident().remove(id);
		} catch (NumberFormatException e) {
		}
		response.sendRedirect("./list");
	}

}
