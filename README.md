# 2020년 2학기 DataBase

# 데이터베이스 시스템 개발

+ 기능(Web으로 구현)	
  1. 데이터를 편리한 GUI를 통하여 새로운 입력한다.
  
  2. 여러 개의 데이터를 하나의 파일(data.csv)에서 읽어서 한꺼번에 입력한다. 각 데이터 별 형식은 아래와 같다. 단 하나의 Record 데이터는 한 줄에 명시된다.   
      -	고객: C, name(key), phone, address, gender
      -	거래: T, transactionNnumber(key), productID, price, date, customerName
      -	상품: P, name, productID(key), supplierName
    
  3.	이 세가지 종류의 데이터를 편리한 GUI를 통하여 검색한다. 검색은 각 데이터 속성을 조건으로 수행한다.
  
  4.	다음의 검색 조건을 특별하게 지원하는 기능도 적절한 GUI로 제공한다.
      -	남자보다 여자가 많이 산 상품의 이름  
      -	주어진 날 이전에 가장 많은 거래(금액기준)가 이루어진 k 가지 상품
      -	하나의 supplier에서 m 번 이상의 제품을 산 고객의 이름
  
