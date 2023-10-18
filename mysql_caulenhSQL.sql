-- THỰC HIỆN CÁC CÂU LỆNH TRUY VẤN SQL
-- 1. In ra danh sách các nhân viên (EMPLOYEEID, FULLNAME, EMAIL, JOBTITLE) làm việc tại văn phòng thuộc khu vực NA.
SELECT
	e. employeeId,
    CONCAT(e.lastName, " ", e.firstName) AS fullName,
    e.email,
    e.jobTitle,
    o.territory
FROM employee e
LEFT jOIN offices o ON e.officeId = o.officeId
WHERE o.territory LIKE 'NA'

-- 2. Tìm các cấp độ của nhân viên theo sơ đồ phân cấp quản lý.
WITH RECURSIVE cte_hierarchy_emp AS 
(
	SELECT 
		employeeId,
		CONCAT(lastName, " ", firstName) AS employeeName,
        reportsTo,
        0 AS employeeLevel
    FROM employees WHERE reportsTo IS NULL
    UNION ALL
    SELECT 
		Emp.employeeId,
        CONCAT(Emp.lastName, " ", Emp.firstName) AS employeeName,
        Emp.reportsTo,
        employeeLevel + 1
    FROM employees Emp
    INNER JOIN cte_hierarchy_emp Mgr ON Emp.reportsTo = Mgr.employeeId
)
SELECT *
FROM cte_hierarchy_emp

-- 3. In ra danh sách 10 khách hàng (CUSTOMERID, CUSTOMERNAME, REVENUE) có doanh số cao nhất theo
-- thứ tự từ cao đến thấp trong năm 2003.
SELECT
	o.customerId, c.customerName,
    SUM(od.quantityOrdered * od.sellPrice) AS Revenue
FROM orders o
JOIN orderdetails od ON o.orderId = od.orderId
JOIN customers c ON o.customerId = c.customerId
WHERE YEAR(orderDate) = 2003
GROUP BY o.customerId, c.customerName
ORDER BY Revenue DESC
LIMIT 10;

-- 4. Có bao nhiêu sản phẩm khác nhau được bán ra theo từng productLine trong tháng 03/2004?
SELECT
	pl.productLine,
    COUNT(DISTINCT(od.productId)) AS SLSanPhamBan
FROM orderdetails od
JOIN orders o ON od.orderId = o.orderId
JOIN products p ON od.productId = p.productId
JOIN productLines pl ON p.productLineId = pl.productLineId
WHERE YEAR(o.orderDate) = 2004 AND MONTH(o.orderDate) = 3
GROUP BY pl.productLine

-- 5. In ra danh sách số lượng tồn kho các sản phẩm (PRODUCTID, PRODUCTNAME) kèm theo tổng số lượng tồn kho 
-- theo từng productLine trong tháng 03/2004. Tính tỷ trọng các sản phẩm trên từng productLine.
WITH inventory_summary AS
(
	SELECT p.productName, pl.productLine, p.quantityInStock,
		SUM(p.quantityInStock) OVER (
			PARTITION BY pl.productLine
			ORDER BY pl.productLine) totalInventoryByProductLine
    FROM products p
    JOIN productlines pl ON p.productLineId = pl.productLineId
)
SELECT *, 
	CONCAT(FORMAT((quantityInStock / totalInventoryByProductLine) * 100, 2), '%') percentage 
FROM inventory_summary
ORDER BY productLine, quantityInStock DESC