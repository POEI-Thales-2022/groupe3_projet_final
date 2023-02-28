package net.pblouet.ajc.incidents.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.pblouet.ajc.incidents.dao.DaoFactory;
import net.pblouet.ajc.incidents.entity.Incident;
import net.pblouet.ajc.incidents.entity.Severity;
import net.pblouet.ajc.incidents.entity.Type;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Servlet implementation class IncidentAddServlet
 */
@WebServlet("/add")
public class IncidentAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<String> severities = Arrays.stream(Severity.values()).map(Severity::toString).collect(Collectors.toList());
		List<String> types = Arrays.stream(Type.values()).map(Type::toString).collect(Collectors.toList());
		request.setAttribute("severities", severities);
		request.setAttribute("types", types);
		request.getRequestDispatcher("WEB-INF/add.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Incident incident = Incident.builder().title(request.getParameter("title"))
					.description(request.getParameter("description")).email(request.getParameter("email"))
					.severity(Severity.valueOf(request.getParameter("severity")))
					.type(Type.valueOf(request.getParameter("type")))
					.progress(Integer.parseInt(request.getParameter("progress"))).build();
			DaoFactory.get().incident().add(incident);
		} catch (IllegalArgumentException e) {
		}
		response.sendRedirect("./list");
	}

}
