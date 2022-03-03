<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.*"%>
<%@page import="testWeb.DBconn"%>
<%@ page language="java" import="java.io.*" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>DB Page</title>

</head>
<body>
	<form name="frm1" method="post" action="DataBase.jsp">

	Type(T/C/P) : <input type="text" name="type" size="20" value="T/C/P" /><br/><br/>
	TransactionNumber/Name/Name : <input type="text" name="trans" size="20" value="" /><br/><br/>
	ProductID/Phone/ProductID : <input type="text" name="prod" size="20" value="" /><br/><br/>
	Price/Address/SupplierName : <input type="text" name="price" size="20" value="" /><br/><br/>
	Date/Gender : <input type="text" name="date" size="20" value="" /><br/><br/>
	CustomerName : <input type="text" name="cus" size="20" value="" /><br/><br/>          

	<input type="submit" name="input" value="Input Data" /> 
	<input type="submit" name="search" value="Search" /><br/><br/>
	
	남자보다 여자가 많이 산 상품 이름 : <input type="submit" name="option1" value="Search (option1)" /><br/><br/><br/>
	
	주어진 날 이전에 가장 많은 거래(금액기준)가 이루어진 k가지 상품 : <br/>
	Date : <input type="text" name="date2" size="20" value="day/month/year" /><br/><br/>
	K : <input type="text" name="k" size="20" value="" /><br/><br/>
	<input type="submit" name="option2" value="Search (option2)" /><br/><br/><br/>
	
	하나의 supplier에서 m 번 이상의 제품을 산 고객의 이름 : <br/>
	SupplierName : <input type="text" name="supplier2" size="20" value="" /><br/><br/>
	M : <input type="text" name="m" size="20" value="" /><br/><br/>
	<input type="submit" name="option3" value="Search (option3)" /><br/><br/><br/>
	
	</form>

	<%! 
		String[][] input = new String[150][6];
	%>
	<% 
		Connection conn = DBconn.getMySqlConnection();
	
		Statement stmt = conn.createStatement();
	
		ResultSet rs = null, rs1 = null, rs2 = null;
	
		String sql = "select * from customer";
		
		try { // csv 데이터 파일 읽기 
			File csv = new File("C:\\Users\\dndbs\\OneDrive\\바탕 화면\\data.csv"); // csv 파일 경로 
			BufferedReader br = new BufferedReader(new FileReader(csv)); 
			String line = ""; 
			int row =0 ,i; 
			while ((line = br.readLine()) != null) { 
				String[] attr = line.split(", "); 
				if(attr[0].equals("C")){
					for(i=0;i<5;i++) { 
						input[row][i] = attr[i];
						//if(i != 4)	out.print(attr[i] + ", ");
						//else	out.print(attr[i] + "<br>");
					}
					sql = "insert into customer(name,phone,address,gender) values (?,?,?,?)";
					PreparedStatement pstmt = conn.prepareStatement(sql);
					try{
						pstmt.setString(1, input[row][1]);
						pstmt.setString(2, input[row][2]);
						pstmt.setString(3, input[row][3]);
						pstmt.setString(4, input[row][4]);
						
						pstmt.executeUpdate();
					} catch (SQLException e){
						e.printStackTrace();
					}
					row++;
				}
				if(attr[0].equals("T")){
					for(i=0;i<6;i++) { 
						input[row][i] = attr[i];
						//if(i != 5)	out.print(attr[i] + ", ");
						//else	out.print(attr[i] + "<br>");
					}
					sql = "insert into trade(transactionNumber,productID,price,date,customerName) values (?,?,?,?,?)";
					PreparedStatement pstmt = conn.prepareStatement(sql);
					try{
						pstmt.setString(1, input[row][1]);
						pstmt.setString(2, input[row][2]);
						pstmt.setString(3, input[row][3]);
						pstmt.setString(4, input[row][4]);
						pstmt.setString(5, input[row][5]);
						
						pstmt.executeUpdate();
					} catch (SQLException e){
						e.printStackTrace();
					}
					row++;
				}
				if(attr[0].equals("P")){
					for(i=0;i<4;i++) { 
						input[row][i] = attr[i];
						//if(i != 3)	out.print(attr[i] + ", ");
						//else	out.print(attr[i] + "<br>");
					}
					sql = "insert into product(name,productID,suplierName) values (?,?,?)";
					PreparedStatement pstmt = conn.prepareStatement(sql);
					try{
						pstmt.setString(1, input[row][1]);
						pstmt.setString(2, input[row][2]);
						pstmt.setString(3, input[row][3]);
						
						pstmt.executeUpdate();
					} catch (SQLException e){
						e.printStackTrace();
					}
					row++; 
				}
			} 
			br.close(); 
		} 
		catch (FileNotFoundException e) { 
			e.printStackTrace(); 
		} 
		catch (IOException e) { 
			e.printStackTrace(); 
		}

		
		//web input data
		request.setCharacterEncoding("UTF-8");
		
		String in = request.getParameter("input");
		String sear = request.getParameter("search");
		String sear1 = request.getParameter("option1");
		String sear2 = request.getParameter("option2");
		String sear3 = request.getParameter("option3");
		
	    if(Objects.equals(in, "Input Data")){
	    	String type = request.getParameter("type");
		    out.println("Type = " + type + "<br/>");
		    if(Objects.equals(type, "T")){
		    	String command = "insert into trade(transactionNumber,productID,price,date,customerName) values (?,?,?,?,?)";
				PreparedStatement pstmt = conn.prepareStatement(command);
				
				String trans = request.getParameter("trans");
			    String prod = request.getParameter("prod");
			    String price = request.getParameter("price");
			    String date = request.getParameter("date");
			    String cus = request.getParameter("cus");
			    
				try{
					pstmt.setString(1, trans);
					pstmt.setString(2, prod);
					pstmt.setString(3, price);
					pstmt.setString(4, date);
					pstmt.setString(5, cus);
					
					pstmt.executeUpdate();
				} catch (SQLException e){
					e.printStackTrace();
				}
				in = "";
		    }
			if(Objects.equals(type, "C")){
				String command = "insert into customer(name,phone,address,gender) values (?,?,?,?)";
				PreparedStatement pstmt = conn.prepareStatement(command);
				
				String name = request.getParameter("trans");
			    String phone = request.getParameter("prod");
			    String address = request.getParameter("price");
			    String gender = request.getParameter("date");
			    
				try{
					pstmt.setString(1, name);
					pstmt.setString(2, phone);
					pstmt.setString(3, address);
					pstmt.setString(4, gender);
					
					pstmt.executeUpdate();
				} catch (SQLException e){
					e.printStackTrace();
				}
				in = "";
			}
			if(Objects.equals(type, "P")){
				String command = "insert into product(name,productID,suplierName) values (?,?,?)";
				PreparedStatement pstmt = conn.prepareStatement(command);
				
				String name = request.getParameter("trans");
			    String prod = request.getParameter("prod");
			    String suplier = request.getParameter("price");
			    
				try{
					pstmt.setString(1, name);
					pstmt.setString(2, prod);
					pstmt.setString(3, suplier);
					
					pstmt.executeUpdate();
				} catch (SQLException e){
					e.printStackTrace();
				}
				in = "";
			}
	    }
		// Search data(각 타입 입력후 속성 입력에 따라 하나만 해도 검색 후 출력)
	    if(Objects.equals(sear, "Search")){
	    	String type = request.getParameter("type");
	    	
	    	if(Objects.equals(type,"T")){
	    		sql = "select * from trade";
	    		rs = stmt.executeQuery(sql);
	    		
	    		String trans = request.getParameter("trans");
			    String prod = request.getParameter("prod");
			    String price = request.getParameter("price");
			    String date = request.getParameter("date");
			    String cus = request.getParameter("cus");
			    
				if(rs.next()){
					do{
						if(Objects.equals(rs.getString("transactionNumber"), trans)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("TransactionNumber = " + rs.getString("transactionNumber") + "<br>");
							out.print("ProductID = " + rs.getString("productID") + "<br>");
							out.print("Price = " + rs.getString("price") + "<br>");
							out.print("Date = " + rs.getString("date") + "<br>");
							out.print("CustomerName = " + rs.getString("customerName") + "<br>");
							sear = "";
							//break;
						}
						else if(Objects.equals(rs.getString("productID"), prod)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("TransactionNumber = " + rs.getString("transactionNumber") + "<br>");
							out.print("ProductID = " + rs.getString("productID") + "<br>");
							out.print("Price = " + rs.getString("price") + "<br>");
							out.print("Date = " + rs.getString("date") + "<br>");
							out.print("CustomerName = " + rs.getString("customerName") + "<br>");
							sear = "";
							//break;
						}
						else if(Objects.equals(rs.getString("price"), price)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("TransactionNumber = " + rs.getString("transactionNumber") + "<br>");
							out.print("ProductID = " + rs.getString("productID") + "<br>");
							out.print("Price = " + rs.getString("price") + "<br>");
							out.print("Date = " + rs.getString("date") + "<br>");
							out.print("CustomerName = " + rs.getString("customerName") + "<br>");
							sear = "";
							//break;
						}
						else if(Objects.equals(rs.getString("date"), date)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("TransactionNumber = " + rs.getString("transactionNumber") + "<br>");
							out.print("ProductID = " + rs.getString("productID") + "<br>");
							out.print("Price = " + rs.getString("price") + "<br>");
							out.print("Date = " + rs.getString("date") + "<br>");
							out.print("CustomerName = " + rs.getString("customerName") + "<br>");
							sear = "";
							//break;
						}
						else if(Objects.equals(rs.getString("customerName"), cus)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("TransactionNumber = " + rs.getString("transactionNumber") + "<br>");
							out.print("ProductID = " + rs.getString("productID") + "<br>");
							out.print("Price = " + rs.getString("price") + "<br>");
							out.print("Date = " + rs.getString("date") + "<br>");
							out.print("CustomerName = " + rs.getString("customerName") + "<br>");
							sear = "";
							//break;
						}
					}while(rs.next());
				}else{
					out.print("No Result" + "<br>");
				}
	    	}
	    	
	    	if(Objects.equals(type,"C")){
	    		sql = "select * from customer";
	    		rs = stmt.executeQuery(sql);
	    		
	    		String name = request.getParameter("trans");
			    String phone = request.getParameter("prod");
			    String address = request.getParameter("price");
			    String gender = request.getParameter("date");
			    
				if(rs.next()){
					do{
						if(Objects.equals(rs.getString("name"), name)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("Name = " + rs.getString("name") + "<br>");
							out.print("Phone = " + rs.getString("phone") + "<br>");
							out.print("Address = " + rs.getString("address") + "<br>");
							out.print("Gender = " + rs.getString("gender") + "<br>");
							sear = "";
							//break;
						}
						else if(Objects.equals(rs.getString("phone"), phone)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("Name = " + rs.getString("name") + "<br>");
							out.print("Phone = " + rs.getString("phone") + "<br>");
							out.print("Address = " + rs.getString("address") + "<br>");
							out.print("Gender = " + rs.getString("gender") + "<br>");
							sear = "";
							//break;
						}
						else if(Objects.equals(rs.getString("address"), address)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("Name = " + rs.getString("name") + "<br>");
							out.print("Phone = " + rs.getString("phone") + "<br>");
							out.print("Address = " + rs.getString("address") + "<br>");
							out.print("Gender = " + rs.getString("gender") + "<br>");
							sear = "";
							//break;
						}
						else if(Objects.equals(rs.getString("gender"), gender)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("Name = " + rs.getString("name") + "<br>");
							out.print("Phone = " + rs.getString("phone") + "<br>");
							out.print("Address = " + rs.getString("address") + "<br>");
							out.print("Gender = " + rs.getString("gender") + "<br>");
							sear = "";
							//break;
						}
					}while(rs.next());
				}else{
					out.print("No Result" + "<br>");
				}
	    	}
	    	
	    	if(Objects.equals(type,"P")){
	    		sql = "select * from product";
	    		rs = stmt.executeQuery(sql);
	    		
	    		String name = request.getParameter("trans");
			    String prod = request.getParameter("prod");
			    String suplier = request.getParameter("price");
			    
				if(rs.next()){
					do{
						if(Objects.equals(rs.getString("name"), name)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("Name = " + rs.getString("name") + "<br>");
							out.print("ProductID = " + rs.getString("productID") + "<br>");
							out.print("SupplierName = " + rs.getString("suplierName") + "<br>");
							sear = "";
							//break;
						}
						else if(Objects.equals(rs.getString("productID"), prod)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("Name = " + rs.getString("name") + "<br>");
							out.print("ProductID = " + rs.getString("productID") + "<br>");
							out.print("SupplierName = " + rs.getString("suplierName") + "<br>");
							sear = "";
							//break;
						}
						else if(Objects.equals(rs.getString("suplierName"), suplier)){
							out.print("---------------Search Result----------------<br><br>");
							out.print("Name = " + rs.getString("name") + "<br>");
							out.print("ProductID = " + rs.getString("productID") + "<br>");
							out.print("SupplierName = " + rs.getString("suplierName") + "<br>");
							sear = "";
							//break;
						}
					}while(rs.next());
				}else{
					out.print("No Result" + "<br>");
				}
	    	}
	    }
		
	    
	    if(Objects.equals(sear1, "Search (option1)")){
	    	sql = "select * from trade";
	    	String sql1 = "select * from customer";
	    	String sql2 = "select * from product";

	    	int cusCnt = 0;
	    	
	    	rs1 = stmt.executeQuery(sql1);
	    	if(rs1.next()){
	    		int i=0;
				do{
					cusCnt++;
				}while(rs1.next());
			}else{
				out.print("No Customer" + "<br>");
			}
	    	
	    	String customerInfo[][] = new String[cusCnt][2]; //name, gender
	    	rs1 = stmt.executeQuery(sql1);
	    	if(rs1.next()){
	    		int i=0;
				do{
					customerInfo[i][0] = rs1.getString("name");;
					customerInfo[i][1] = rs1.getString("gender");		
					i++;
				}while(rs1.next());
			}else{
				out.print("No Customer" + "<br>");
			}
	    	
    		rs = stmt.executeQuery(sql);
       		int tradeCnt = 0;
    		
    		if(rs.next()){
				do{
					tradeCnt++;
				}while(rs.next());
			}else{
				out.print("No Trade" + "<br>");
			}

    		if(tradeCnt > 0){
    			rs = stmt.executeQuery(sql);
	    		String tradeProduct[][] = new String[tradeCnt][3]; //productid, mcnt, fcnt
	    		String nu = null;
	    		
	    		if(rs.next()){
	    			int i = 0;
					do{	
						tradeProduct[i][0] = rs.getString("productID");
						tradeProduct[i][1] = "0";
						tradeProduct[i][2] = "0";
						
						for(int j=0; j<cusCnt; j++){
							if(Objects.equals(rs.getString("customerName"), customerInfo[j][0])){
								if(Objects.equals(customerInfo[j][1], "Male"))	tradeProduct[i][1] = "1";
								if(Objects.equals(customerInfo[j][1], "Female"))	tradeProduct[i][2] = "1";
							}
						}
						i++;
					}while(rs.next());
				}
	    		
	    		for(int i=0; i<tradeCnt-1; i++){
	    			for(int j=i+1; j<tradeCnt; j++){
		    			if(Objects.equals(tradeProduct[i][0], tradeProduct[j][0])){
		    				int mcnt1 = Integer.parseInt(tradeProduct[i][1]);
		    				int mcnt2 = Integer.parseInt(tradeProduct[j][1]);
		    				int fcnt1 = Integer.parseInt(tradeProduct[i][2]);
		    				int fcnt2 = Integer.parseInt(tradeProduct[j][2]);
		    				
		    				tradeProduct[j][0] = "duplicate";
		    				tradeProduct[i][1] = Integer.toString(mcnt1+mcnt2);
		    				tradeProduct[i][2] = Integer.toString(fcnt1+fcnt2);
		    			}
	    			}
				}
	    		
	    		out.print("---------------Search Result(Option1)----------------<br><br>");
	    		for(int i=0; i<tradeCnt; i++){
	    			if(!Objects.equals(tradeProduct[i][0], "duplicate")){
		    			int mcnt = Integer.parseInt(tradeProduct[i][1]);
		    			int fcnt = Integer.parseInt(tradeProduct[i][2]);
		    			if(mcnt < fcnt){
		    				rs2 = stmt.executeQuery(sql2);
		    				if(rs2.next()){
		    					do{	
		    						if(Objects.equals(rs2.getString("productID"), tradeProduct[i][0])){
		    							out.print("ProductName = " + rs2.getString("name") + "<br>");
		    						}
		    					}while(rs2.next());
		    				}
		    			}
	    			}
	    		}
    		}
    		sear1 = "";
	    }
	    
	    
	    if(Objects.equals(sear2, "Search (option2)")){
	    	String date2 = request.getParameter("date2");
	    	String k = request.getParameter("k");
	    	String sql2 = "select * from product";
	    	String nu = null;
	    	sql = "select * from trade";
	    	int kcnt = Integer.parseInt(k);
	    	
	    	String dateSplit[] = date2.split("/"); //day,month,year
	    	int day = Integer.parseInt(dateSplit[0]);
	    	int month = Integer.parseInt(dateSplit[1]);
	    	int year = Integer.parseInt(dateSplit[2]);
	    	
	    	rs = stmt.executeQuery(sql);
       		int tradeCnt = 0;
    		
    		if(rs.next()){
				do{
					tradeCnt++;
				}while(rs.next());
			}else{
				out.print("No Trade" + "<br>");
			}
    		
	    	String tradeProduct[][] = new String[tradeCnt][2]; //productID, price
	    	rs = stmt.executeQuery(sql);
	    	int tmp=0;
	    	if(rs.next()){
				do{
					String realDate[] = rs.getString("date").split("/");
					int realDay = Integer.parseInt(realDate[0]);
					int realMonth = Integer.parseInt(realDate[1]);
					int realYear = Integer.parseInt(realDate[2]);
					if(year >= realYear || (year >= realYear && month >= realMonth) || (year >= realYear && month >= realMonth && day > realDay)){
						tradeProduct[tmp][0] = rs.getString("productID");
						tradeProduct[tmp][1] = rs.getString("price");
						tmp++;
					}
				}while(rs.next());
			}
	    	
	    	for(int i=0; i<tradeCnt-1; i++){
    			for(int j=i+1; j<tradeCnt; j++){
    				if(Objects.equals(tradeProduct[i][0], tradeProduct[j][0]) && !Objects.equals(tradeProduct[i][0], nu)){
    					String price1 = tradeProduct[i][1].substring(1, tradeProduct[i][1].length());
    					String price2 = tradeProduct[j][1].substring(1, tradeProduct[j][1].length());
    					double realPrice1 = Double.parseDouble(price1);
    					double realPrice2 = Double.parseDouble(price2);
    					tradeProduct[i][1] = "$" + Double.toString(realPrice1+realPrice2);
    					
    					tradeProduct[j][0] = "";
    				}
    			}
    		}
	    	
	    	String selID[] = new String[kcnt];
	    	int cnt = kcnt;
	    	while(cnt != 0){
	    		double maxPrice = Double.parseDouble(tradeProduct[0][1].substring(1, tradeProduct[0][1].length()));
	    		int maxi = 0;
	    		for(int i=1; i<tradeCnt; i++){
	    			if(!Objects.equals(tradeProduct[i][0], "") && !Objects.equals(tradeProduct[i][1], nu) && maxPrice < Double.parseDouble(tradeProduct[i][1].substring(1, tradeProduct[i][1].length()))){
	    				maxPrice = Double.parseDouble(tradeProduct[i][1].substring(1, tradeProduct[i][1].length()));
	    				maxi = i;
	    			}
	    		}	
	    		selID[kcnt-cnt] = tradeProduct[maxi][0];
	    		tradeProduct[maxi][1] = "$0.00001";
	    		cnt--;
	    	}
	    	
	    	out.print("---------------Search Result(Option2)----------------<br><br>");
	    	for(int i=0; i<kcnt; i++){
		    	rs2 = stmt.executeQuery(sql2);
				if(rs2.next()){
					do{	
						if(Objects.equals(rs2.getString("productID"), selID[i])){
							out.print("ProductName = " + rs2.getString("name") + "<br>");
						}
					}while(rs2.next());
				}
	    	}
	    	
	    	
	    	sear2 = "";
	    }
	    
	   	
	    if(Objects.equals(sear3, "Search (option3)")){
	    	String supplier2 = request.getParameter("supplier2");
	    	String m = request.getParameter("m");
	    	String nu = null;
	    	int mcnt = Integer.parseInt(m);
	    	
	    	String pid[] = new String[15];
	    	String sql2 = "select * from product";
	    	rs2 = stmt.executeQuery(sql2);
	    	int k=0; 
			if(rs2.next()){
				do{	
					if(Objects.equals(rs2.getString("suplierName"), supplier2)){
						pid[k] = rs2.getString("productID");
						k++;
					}
				}while(rs2.next());
			}
			
			String dupName[] = new String[100];
			String sql1 = "select * from trade";
			rs1 = stmt.executeQuery(sql1);
			int t=0;
			if(rs1.next()){
				do{	
					for(int i=0; i<15; i++){
						if(!Objects.equals(pid[i], nu) && Objects.equals(rs1.getString("productID"), pid[i])){
							dupName[t] = rs1.getString("customerName");
							t++;
						}
					}
				}while(rs1.next());
			}
			
			out.print("---------------Search Result(Option3)----------------<br><br>");
			
			for(int i=0; i<99; i++){
				if(!Objects.equals(dupName[i], nu) && !Objects.equals(dupName[i], "")){
					String sel = dupName[i];
					int cnt = 1;
					for(int j=i+1; j<100; j++){
						if(Objects.equals(sel, dupName[j])){
							dupName[j] = "";
							cnt++;
							if(cnt == mcnt)	out.print("CustomerName = " + dupName[i] + "<br>");
						}
					}
				}
			}
				
				
				
			//for(int i=0; i<100; i++)	out.print(dupName[i]+"<br>");
	    	//suppname에 따라 파는 productid 배열 저장 -> trade에서 productid에 따라 이름 저장-> 이름 세고 m이상이면 선택
	    	
	    	
	    	
	    	sear3 = "";
	    }
	%>
</body>
</html>