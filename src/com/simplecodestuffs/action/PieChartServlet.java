package com.simplecodestuffs.action;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.jdbc.JDBCCategoryDataset;
import org.jfree.data.jdbc.JDBCPieDataset;

import com.simplecodestuffs.jdbc.DataAccessObject;

public class PieChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection dbConnection = null;

	public PieChartServlet() {
		dbConnection = DataAccessObject.getConnection();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    JDBCCategoryDataset dataset = new JDBCCategoryDataset(dbConnection);
    
    try {
    dataset.executeQuery("SELECT id,filename,precession FROM analysis");
    
    JFreeChart chart = ChartFactory.createBarChart(
           "precession", "file number", "precession",
           dataset, PlotOrientation.VERTICAL, false, true, false);           
           chart.setBorderVisible(true);
    
    if (chart != null) {
            int width = 600;
            int height = 400;
            response.setContentType("image/jpeg");
            OutputStream out = response.getOutputStream();
            ChartUtilities.writeChartAsJPEG(out, chart, width, height);
    }
    }
    catch (SQLException e) {
            System.err.println(e.getMessage());
    }
	}
	public void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	}
}