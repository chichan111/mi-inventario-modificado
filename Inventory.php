<?php
class Inventory
{
	private $host  = 'localhost';
	private $user  = 'root';
	private $password   = '';
	private $database  = 'reactivos';
	private $userTable = 'ims_user';
	private $customerTable = 'ims_customer';
	private $categoryTable = 'ims_category';
	private $brandTable = 'ims_brand';
	private $productTable = 'ims_product';
	private $supplierTable = 'ims_supplier';
	private $purchaseTable = 'ims_purchase';
	private $orderTable = 'ims_order';
	private $dbConnect = false;
	public function __construct()
	{
		if (!$this->dbConnect) {
			$conn = new mysqli($this->host, $this->user, $this->password, $this->database);
			if ($conn->connect_error) {
				die("Error failed to connect to MySQL: " . $conn->connect_error);
			} else {
				$this->dbConnect = $conn;
			}
		}
	}
	private function getData($sqlQuery)
	{
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		if (!$result) {
			die('Error in query: ' . mysqli_error());
		}
		$data = array();
		while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
			$data[] = $row;
		}
		return $data;
	}
	private function getNumRows($sqlQuery)
	{
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		if (!$result) {
			die('Error in query: ' . mysqli_error());
		}
		$numRows = mysqli_num_rows($result);
		return $numRows;
	}
	public function login($email, $password)
	{
		$password = md5($password);
		$sqlQuery = "
			SELECT userid, email, password, name, type, status
			FROM " . $this->userTable . " 
			WHERE email='" . $email . "' AND password='" . $password . "'";
		return  $this->getData($sqlQuery);
	}
	public function checkLogin()
	{
		if (empty($_SESSION['userid'])) {
			header("Location:login.php");
		}
	}
	public function getCustomer()
	{
		$sqlQuery = "
			SELECT * FROM " . $this->customerTable . " 
			WHERE id = '" . $_POST["userid"] . "'";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
		echo json_encode($row);
	}

	public function getCustomerList() {
		try {
			$sqlQuery = "SELECT * FROM " . $this->customerTable . " ";
			if (!empty($_POST["search"]["value"])) {
				$searchValue = mysqli_real_escape_string($this->dbConnect, $_POST["search"]["value"]);
				$sqlQuery .= 'WHERE (id LIKE "%' . $searchValue . '%" ';
				$sqlQuery .= 'OR name LIKE "%' . $searchValue . '%" ';
				$sqlQuery .= 'OR address LIKE "%' . $searchValue . '%") ';
			}
	
			// Total records without filtering
			$totalRecords = $this->getNumRows("SELECT COUNT(*) as total FROM " . $this->customerTable);
	
			// Total records with filtering
			$totalRecordwithFilter = $this->getNumRows($sqlQuery);
	
			if (!empty($_POST["order"])) {
				$sqlQuery .= 'ORDER BY ' . $_POST['order']['0']['column'] . ' ' . $_POST['order']['0']['dir'] . ' ';
			} else {
				$sqlQuery .= 'ORDER BY id DESC ';
			}
			if ($_POST["length"] != -1) {
				$sqlQuery .= 'LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
			}
	
			$result = mysqli_query($this->dbConnect, $sqlQuery);
			$customerData = array();
			
			while ($customer = mysqli_fetch_assoc($result)) {
				$customerRows = array();
				$customerRows[] = $customer['id'];
				$customerRows[] = $customer['name'];
				$customerRows[] = $customer['address'];
				$customerRows[] = '<div class="btn-group btn-group-sm">
									<button type="button" name="update" id="' . $customer["id"] . '" class="btn btn-primary rounded-0 update" title="Editar">
										<i class="fa fa-edit"></i>
									</button>
									<button type="button" name="delete" id="' . $customer["id"] . '" class="btn btn-danger rounded-0 delete" title="Eliminar">
										<i class="fa fa-trash"></i>
									</button>
								 </div>';
				$customerData[] = $customerRows;
			}
	
			$output = array(
				"draw"              => intval($_POST["draw"]),
				"recordsTotal"      => $totalRecords,
				"recordsFiltered"   => $totalRecordwithFilter,
				"data"              => $customerData
			);
	
			echo json_encode($output);
		} catch (Exception $e) {
			echo json_encode(array("error" => $e->getMessage()));
		}
	}

	public function saveCustomer()
	{
		$sqlInsert = "
			INSERT INTO " . $this->customerTable . "(name, address, mobile, balance) 
			VALUES ('" . $_POST['cname'] . "', '" . $_POST['address'] . "', '" . $_POST['mobile'] . "', '" . $_POST['balance'] . "')";
		mysqli_query($this->dbConnect, $sqlInsert);
		echo 'New Customer Added';
	}
	public function updateCustomer()
	{
		if ($_POST['userid']) {
			$sqlInsert = "
				UPDATE " . $this->customerTable . " 
				SET name = '" . $_POST['cname'] . "', address= '" . $_POST['address'] . "', mobile = '" . $_POST['mobile'] . "', balance = '" . $_POST['balance'] . "' 
				WHERE id = '" . $_POST['userid'] . "'";
			mysqli_query($this->dbConnect, $sqlInsert);
			echo 'Customer Edited';
		}
	}
	public function deleteCustomer()
	{
		$sqlQuery = "
			DELETE FROM " . $this->customerTable . " 
			WHERE id = '" . $_POST['userid'] . "'";
		mysqli_query($this->dbConnect, $sqlQuery);
	}
	// Category functions
	public function getCategoryList()
	{
		$sqlQuery = "SELECT * FROM " . $this->categoryTable . " ";
		if (!empty($_POST["search"]["value"])) {
			$sqlQuery .= 'WHERE (name LIKE "%' . $_POST["search"]["value"] . '%" ';
			$sqlQuery .= 'OR status LIKE "%' . $_POST["search"]["value"] . '%") ';
		}
		if (!empty($_POST["order"])) {
			$sqlQuery .= 'ORDER BY ' . $_POST['order']['0']['column'] . ' ' . $_POST['order']['0']['dir'] . ' ';
		} else {
			$sqlQuery .= 'ORDER BY categoryid DESC ';
		}
		if ($_POST["length"] != -1) {
			$sqlQuery .= 'LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
		}
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$numRows = mysqli_num_rows($result);
		$categoryData = array();
		while ($category = mysqli_fetch_assoc($result)) {
			$categoryRows = array();
			$status = '';
			if ($category['status'] == 'active') {
				$status = '<span class="label label-success">Active</span>';
			} else {
				$status = '<span class="label label-danger">Inactive</span>';
			}
			$categoryRows[] = $category['categoryid'];
			$categoryRows[] = $category['name'];
			$categoryRows[] = $status;
			$categoryRows[] = '<button type="button" name="update" id="' . $category["categoryid"] . '" class="btn btn-primary btn-sm rounded-0 update" title="Update"><i class="fa fa-edit"></i></button><button type="button" name="delete" id="' . $category["categoryid"] . '" class="btn btn-danger btn-sm rounded-0 delete"  title="Delete"><i class="fa fa-trash"></i></button>';
			$categoryData[] = $categoryRows;
		}
		$output = array(
			"draw"				=>	intval($_POST["draw"]),
			"recordsTotal"  	=>  $numRows,
			"recordsFiltered" 	=> 	$numRows,
			"data"    			=> 	$categoryData
		);
		echo json_encode($output);
	}
	public function saveCategory()
	{
		$sqlInsert = "
			INSERT INTO " . $this->categoryTable . "(name) 
			VALUES ('" . $_POST['category'] . "')";
		mysqli_query($this->dbConnect, $sqlInsert);
		echo 'New Category Added';
	}
	public function getCategory()
	{
		$sqlQuery = "
			SELECT * FROM " . $this->categoryTable . " 
			WHERE categoryid = '" . $_POST["categoryId"] . "'";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
		echo json_encode($row);
	}
	public function updateCategory()
	{
		if ($_POST['category']) {
			$sqlInsert = "
				UPDATE " . $this->categoryTable . " 
				SET name = '" . $_POST['category'] . "'
				WHERE categoryid = '" . $_POST["categoryId"] . "'";
			mysqli_query($this->dbConnect, $sqlInsert);
			echo 'Category Update';
		}
	}
	public function deleteCategory()
	{
		$sqlQuery = "
			DELETE FROM " . $this->categoryTable . " 
			WHERE categoryid = '" . $_POST["categoryId"] . "'";
		mysqli_query($this->dbConnect, $sqlQuery);
	}
	// Brand management 
	public function getBrandList() {
		try {
			$sqlQuery = "SELECT b.* FROM " . $this->brandTable . " as b ";
	
			if (!empty($_POST["search"]["value"])) {
				$sqlQuery .= 'WHERE b.bname LIKE "%' . $_POST["search"]["value"] . '%" ';
				$sqlQuery .= 'OR b.status LIKE "%' . $_POST["search"]["value"] . '%" ';
			}
	
			if (!empty($_POST["order"])) {
				$sqlQuery .= 'ORDER BY ' . $_POST['order']['0']['column'] . ' ' . $_POST['order']['0']['dir'] . ' ';
			} else {
				$sqlQuery .= 'ORDER BY b.id DESC ';
			}
	
			if ($_POST["length"] != -1) {
				$sqlQuery .= 'LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
			}
	
			$result = mysqli_query($this->dbConnect, $sqlQuery);
			$numRows = mysqli_num_rows($result);
			$brandData = array();
	
			while ($brand = mysqli_fetch_assoc($result)) {
				$status = '';
				if ($brand['status'] == 'active') {
					$status = '<span class="label label-success">Activo</span>';
				} else {
					$status = '<span class="label label-danger">Inactivo</span>';
				}
	
				$brandRows = array();
				$brandRows[] = $brand['id'];
				$brandRows[] = $brand['bname'];
				$brandRows[] = $status;
				$brandRows[] = '<div class="btn-group btn-group-sm">
								<button type="button" name="update" id="' . $brand["id"] . '" class="btn btn-primary rounded-0 update" title="Editar">
									<i class="fa fa-edit"></i>
								</button>
								<button type="button" name="delete" id="' . $brand["id"] . '" class="btn btn-danger rounded-0 delete" data-status="' . $brand["status"] . '" title="Eliminar">
									<i class="fa fa-trash"></i>
								</button>
							  </div>';
				$brandData[] = $brandRows;
			}
	
			$output = array(
				"draw"              => intval($_POST["draw"]),
				"recordsTotal"      => $numRows,
				"recordsFiltered"   => $numRows,
				"data"              => $brandData
			);
	
			echo json_encode($output);
		} catch (Exception $e) {
			echo json_encode(array("error" => $e->getMessage()));
		}
	}
	
	
	public function categoryDropdownList()
	{
		$sqlQuery = "SELECT * FROM " . $this->categoryTable . " 
			WHERE status = 'active' 
			ORDER BY name ASC";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$categoryHTML = '';
		while ($category = mysqli_fetch_assoc($result)) {
			$categoryHTML .= '<option value="' . $category["categoryid"] . '">' . $category["name"] . '</option>';
		}
		return $categoryHTML;
	}
	public function saveBrand() {
		try {
			// Validar datos de entrada
			if (empty($_POST['bname'])) {
				throw new Exception("El nombre de la marca es requerido");
			}
	
			// Preparar la consulta incluyendo categoryid
			$stmt = $this->dbConnect->prepare("INSERT INTO " . $this->brandTable . " (bname, status, categoryid) VALUES (?, 'active', 1)");
			if (!$stmt) {
				throw new Exception("Error en la preparación de la consulta: " . $this->dbConnect->error);
			}
	
			// Bind de parámetros y ejecución
			$bname = trim($_POST['bname']);
			$stmt->bind_param("s", $bname);
	
			if (!$stmt->execute()) {
				throw new Exception("Error al ejecutar la consulta: " . $stmt->error);
			}
	
			if ($stmt->affected_rows === 0) {
				throw new Exception("No se pudo insertar la marca");
			}
	
			$stmt->close();
			echo json_encode(array("success" => true, "message" => "Marca agregada correctamente"));
		} catch (Exception $e) {
			error_log("Error en saveBrand: " . $e->getMessage());
			echo json_encode(array("success" => false, "message" => $e->getMessage()));
		}
	}
	
	public function getBrand() {
		try {
			$stmt = $this->dbConnect->prepare("SELECT * FROM " . $this->brandTable . " WHERE id = ?");
			if (!$stmt) {
				throw new Exception("Error en la preparación: " . $this->dbConnect->error);
			}
	
			$stmt->bind_param("i", $_POST["id"]);
			
			if (!$stmt->execute()) {
				throw new Exception("Error al ejecutar la consulta: " . $stmt->error);
			}
	
			$result = $stmt->get_result();
			$row = $result->fetch_assoc();
	
			if (!$row) {
				throw new Exception("No se encontró la marca");
			}
	
			echo json_encode($row);
			$stmt->close();
		} catch (Exception $e) {
			error_log("Error en getBrand: " . $e->getMessage());
			echo json_encode(array("error" => $e->getMessage()));
		}
	}
	public function updateBrand() {
		try {
			if (empty($_POST['id']) || empty($_POST['bname'])) {
				throw new Exception("Datos incompletos para actualizar la marca");
			}
	
			$stmt = $this->dbConnect->prepare("UPDATE " . $this->brandTable . " SET bname = ? WHERE id = ?");
			if (!$stmt) {
				throw new Exception("Error en la preparación: " . $this->dbConnect->error);
			}
	
			$stmt->bind_param("si", $_POST['bname'], $_POST['id']);
	
			if (!$stmt->execute()) {
				throw new Exception("Error al actualizar la marca: " . $stmt->error);
			}
	
			if ($stmt->affected_rows === 0) {
				throw new Exception("No se realizaron cambios en la marca");
			}
	
			$stmt->close();
			echo json_encode(array("success" => true, "message" => "Marca actualizada correctamente"));
		} catch (Exception $e) {
			error_log("Error en updateBrand: " . $e->getMessage());
			echo json_encode(array("success" => false, "message" => $e->getMessage()));
		}
	}
	
	public function deleteBrand() {
		try {
			if (empty($_POST["id"])) {
				throw new Exception("ID de marca no proporcionado");
			}
	
			$stmt = $this->dbConnect->prepare("DELETE FROM " . $this->brandTable . " WHERE id = ?");
			if (!$stmt) {
				throw new Exception("Error en la preparación: " . $this->dbConnect->error);
			}
	
			$stmt->bind_param("i", $_POST["id"]);
	
			if (!$stmt->execute()) {
				throw new Exception("Error al eliminar la marca: " . $stmt->error);
			}
	
			if ($stmt->affected_rows === 0) {
				throw new Exception("No se encontró la marca para eliminar");
			}
	
			$stmt->close();
			echo json_encode(array("success" => true, "message" => "Marca eliminada correctamente"));
		} catch (Exception $e) {
			error_log("Error en deleteBrand: " . $e->getMessage());
			echo json_encode(array("success" => false, "message" => $e->getMessage()));
		}
	}
	// Product management 
	
	public function getProductList() {
		// Consulta base sin límites
		$baseQuery = "SELECT p.*, b.bname, c.name as category_name 
					 FROM " . $this->productTable . " as p
					 LEFT JOIN " . $this->brandTable . " as b ON b.id = p.brandid
					 LEFT JOIN " . $this->categoryTable . " as c ON c.categoryid = p.categoryid ";
	
		// Condiciones de búsqueda
		$whereConditions = [];
		if (!empty($_POST["search"]["value"])) {
			$searchValue = mysqli_real_escape_string($this->dbConnect, $_POST["search"]["value"]);
			$whereConditions[] = "(p.pname LIKE '%$searchValue%' 
								   OR p.model LIKE '%$searchValue%' 
								   OR p.description LIKE '%$searchValue%' 
								   OR b.bname LIKE '%$searchValue%' 
								   OR c.name LIKE '%$searchValue%')";
		}
	
		// Agregar condiciones WHERE
		$whereSQL = '';
		if (!empty($whereConditions)) {
			$whereSQL = " WHERE " . implode(" AND ", $whereConditions);
		}
	
		// Total de registros sin filtrar
		$totalQuery = "SELECT COUNT(*) as total FROM " . $this->productTable;
		$totalResult = mysqli_query($this->dbConnect, $totalQuery);
		$totalRow = mysqli_fetch_assoc($totalResult);
		$totalRecords = $totalRow['total'];
	
		// Total de registros filtrados
		$filteredQuery = $baseQuery . $whereSQL;
		$filteredResult = mysqli_query($this->dbConnect, $filteredQuery);
		$totalFiltered = mysqli_num_rows($filteredResult);
	
		// Ordenamiento
		$orderSQL = " ORDER BY p.pid DESC";
		if (isset($_POST['order'])) {
			$columns = [
				0 => 'p.pid',
				1 => 'p.pname',
				2 => 'p.model',
				3 => 'p.description',
				4 => 'b.bname',
				5 => 'p.quantity',
				6 => 'p.unit',
				8 => 'c.name',
				9 => 'p.date'
			];
			
			$columnIndex = $_POST['order']['0']['column'];
			$columnDir = $_POST['order']['0']['dir'];
			
			if (isset($columns[$columnIndex])) {
				$orderSQL = " ORDER BY " . $columns[$columnIndex] . " " . $columnDir;
			}
		}
	
		// Consulta final con paginación
		$query = $baseQuery . $whereSQL . $orderSQL;
		
		if ($_POST['length'] != -1) {
			$query .= " LIMIT " . $_POST['start'] . ", " . $_POST['length'];
		}
	
		$result = mysqli_query($this->dbConnect, $query);
		$productData = [];
	
		while ($product = mysqli_fetch_assoc($result)) {
			// Estado del stock
			$stock_status = '';
			$quantity = $product['quantity'];
	
			if ($quantity > 10) {
				$stock_status = '<span class="badge bg-success">OK</span>';
			} elseif ($quantity > 5) {
				$stock_status = '<span class="badge bg-warning">BAJO</span>';
			} elseif ($quantity > 0) {
				$stock_status = '<span class="badge bg-orange" style="background-color: #fd7e14;">CRÍTICO</span>';
			} else {
				$stock_status = '<span class="badge bg-danger">SIN STOCK</span>';
			}
	
			// Estado de la fecha de vencimiento
			$date_class = '';
			$status_text = '';
			
			if (!empty($product['date']) && $product['date'] != '0000-00-00') {
				$current_date = new DateTime();
				$current_date->setTime(0, 0, 0);
				$product_date = new DateTime($product['date']);
				$product_date->setTime(0, 0, 0);
				
				$interval = $current_date->diff($product_date);
				$days_difference = $interval->days * ($interval->invert ? -1 : 1);
				$formatted_date = $product_date->format('d/m/Y');
	
				if ($days_difference <= 0) {
					$date_class = 'date-expired';
					$status_text = '<span class="badge bg-danger">VENCIDO</span>';
				} elseif ($days_difference <= 90) {
					$date_class = 'date-warning';
					$status_text = '<span class="badge bg-orange" style="background-color: #fd7e14;">PRÓXIMO A VENCER</span>';
				} else {
					$date_class = 'date-ok';
					$status_text = '<span class="badge bg-success">OK</span>';
				}
			} else {
				$formatted_date = 'Sin fecha';
				$date_class = 'date-warning';
				$status_text = '<span class="badge bg-warning">SIN FECHA</span>';
			}
			
			$date_html = '<div class="text-center">';
			$date_html .= '<div class="date-container ' . $date_class . '">';
			$date_html .= '<div class="date">' . $formatted_date . '</div>';
			$date_html .= '<div class="status">' . $status_text . '</div>';
			$date_html .= '</div>';
			$date_html .= '</div>';
			
			$productRow = [];
			$productRow[] = $product['pid'];
			$productRow[] = $product['pname'];
			$productRow[] = $product['model'];
			$productRow[] = $product['description'];
			$productRow[] = $product['bname'];
			$productRow[] = $product['category_name'];
			$productRow[] = $product['quantity'];
			$productRow[] = $product['unit'];
			$productRow[] = '<div class="text-center">' . $stock_status . '</div>';
			$productRow[] = $date_html;
			$productRow[] = '<div class="btn-group btn-group-sm">
								<button type="button" name="view" id="' . $product["pid"] . '" class="btn btn-light bg-gradient border text-dark btn-sm rounded-0 view" title="Ver">
									<i class="fa fa-eye"></i>
								</button>
								<button type="button" name="update" id="' . $product["pid"] . '" class="btn btn-primary btn-sm rounded-0 update" title="Editar">
									<i class="fa fa-edit"></i>
								</button>
								<button type="button" name="delete" id="' . $product["pid"] . '" class="btn btn-danger btn-sm rounded-0 delete" title="Eliminar">
									<i class="fa fa-trash"></i>
								</button>
							</div>';
			
			$productData[] = $productRow;
		}
	
		$output = [
			"draw" => intval($_POST["draw"]),
			"recordsTotal" => $totalRecords,
			"recordsFiltered" => $totalFiltered,
			"data" => $productData
		];
	
		echo json_encode($output);
	}

	public function getCategoryBrand($categoryid)
	{
		$sqlQuery = "SELECT * FROM " . $this->brandTable . " 
			WHERE status = 'active' AND categoryid = '" . $categoryid . "'	ORDER BY bname ASC";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$dropdownHTML = '';
		while ($brand = mysqli_fetch_assoc($result)) {
			$dropdownHTML .= '<option value="' . $brand["id"] . '">' . $brand["bname"] . '</option>';
		}
		return $dropdownHTML;
	}
	public function supplierDropdownList()
	{
		$sqlQuery = "SELECT * FROM " . $this->supplierTable . " 
			WHERE status = 'active'	ORDER BY supplier_name ASC";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$dropdownHTML = '';
		while ($supplier = mysqli_fetch_assoc($result)) {
			$dropdownHTML .= '<option value="' . $supplier["supplier_id"] . '">' . $supplier["supplier_name"] . '</option>';
		}
		return $dropdownHTML;
	}
	public function addProduct() {
		$sqlInsert = "
			INSERT INTO " . $this->productTable . "(categoryid, brandid, pname, model, description, quantity, unit, base_price, tax, minimum_order, supplier, date) 
			VALUES ('" . $_POST["categoryid"] . "', '" . $_POST['brandid'] . "', '" . $_POST['pname'] . "', '" . $_POST['pmodel'] . "', '" . $_POST['description'] . "', '" . $_POST['quantity'] . "', '" . $_POST['unit'] . "', '" . $_POST['base_price'] . "', '" . $_POST['tax'] . "', 1, '" . $_POST['supplierid'] . "', '" . $_POST['date'] . "')";
		mysqli_query($this->dbConnect, $sqlInsert);
		echo 'Producto Agregado';
	}

	public function brandDropdownList() {
		$sqlQuery = "SELECT * FROM " . $this->brandTable . " 
					 WHERE status = 'active' 
					 ORDER BY bname ASC";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$dropdownHTML = '';
		while ($brand = mysqli_fetch_assoc($result)) {
			$dropdownHTML .= '<option value="' . $brand["id"] . '">' . $brand["bname"] . '</option>';
		}
		return $dropdownHTML;
	}

	public function getProductDetails() {
		$sqlQuery = "SELECT * FROM " . $this->productTable . " 
					 WHERE pid = '" . $_POST["pid"] . "'";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$output = array();
		while ($product = mysqli_fetch_assoc($result)) {
			$output['pid'] = $product['pid'];
			$output['categoryid'] = $product['categoryid'];
			$output['brandid'] = $product['brandid'];
			$output['pname'] = $product['pname'];
			$output['model'] = $product['model'];
			$output['description'] = $product['description'];
			$output['quantity'] = $product['quantity'];
			$output['unit'] = $product['unit'];
			$output['base_price'] = $product['base_price'];
			$output['tax'] = $product['tax'];
			$output['supplier'] = $product['supplier'];
			$output['date'] = $product['date'];
		}
		echo json_encode($output);
	}
	public function updateProduct() {
		if ($_POST['pid']) {
			$sqlUpdate = "UPDATE " . $this->productTable . " 
				SET categoryid = '" . $_POST['categoryid'] . "', 
					brandid='" . $_POST['brandid'] . "', 
					pname='" . $_POST['pname'] . "', 
					model='" . $_POST['pmodel'] . "', 
					description='" . $_POST['description'] . "', 
					quantity='" . $_POST['quantity'] . "', 
					unit='" . $_POST['unit'] . "', 
					base_price='" . $_POST['base_price'] . "', 
					tax='" . $_POST['tax'] . "', 
					supplier='" . $_POST['supplierid'] . "',
					date='" . $_POST['date'] . "'
				WHERE pid = '" . $_POST["pid"] . "'";
			mysqli_query($this->dbConnect, $sqlUpdate);
			echo 'Producto Actualizado';
		}
	}
	public function deleteProduct()
	{
		$sqlQuery = "
			DELETE FROM " . $this->productTable . " 
			WHERE pid = '" . $_POST["pid"] . "'";
		mysqli_query($this->dbConnect, $sqlQuery);
	}

	public function viewProductDetails() {
		$sqlQuery = "SELECT * FROM " . $this->productTable . " as p
			INNER JOIN " . $this->brandTable . " as b ON b.id = p.brandid
			INNER JOIN " . $this->categoryTable . " as c ON c.categoryid = p.categoryid 
			WHERE p.pid = '" . $_POST["pid"] . "'";
		
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$productDetails = '<div class="table-responsive">
				<table class="table table-bordered">';
		
		while ($product = mysqli_fetch_assoc($result)) {
			// Determinar el estado del stock
			$stock_status = '';
			$quantity = $product['quantity'];
	
			if ($quantity > 10) {
				$stock_status = '<span class="badge bg-success">OK</span>';
			} elseif ($quantity > 5) {
				$stock_status = '<span class="badge bg-warning">BAJO</span>';
			} elseif ($quantity > 0) {
				$stock_status = '<span class="badge bg-orange" style="background-color: #fd7e14;">CRÍTICO</span>';
			} else {
				$stock_status = '<span class="badge bg-danger">SIN STOCK</span>';
			}
	
			// Determinar el estado de la fecha de vencimiento
			$date_html = '';
			if (!empty($product['date']) && $product['date'] != '0000-00-00') {
				$current_date = new DateTime();
				$current_date->setTime(0, 0, 0); // Resetear la hora a 00:00:00
				$product_date = new DateTime($product['date']);
				$product_date->setTime(0, 0, 0); // Resetear la hora a 00:00:00
				
				// Calcular la diferencia en días
				$interval = $current_date->diff($product_date);
				$days_difference = $interval->days * ($interval->invert ? -1 : 1);
				$formatted_date = $product_date->format('d/m/Y');
	
				if ($days_difference <= 0) {
					$status_badge = '<span class="badge bg-danger">VENCIDO</span>';
					$date_class = 'date-expired';
				} elseif ($days_difference <= 90) {
					$status_badge = '<span class="badge bg-orange" style="background-color: #fd7e14;">PRÓXIMO A VENCER</span>';
					$date_class = 'date-warning';
				} else {
					$status_badge = '<span class="badge bg-success">OK</span>';
					$date_class = 'date-ok';
				}
	
				$date_html = '<div class="date-container ' . $date_class . '">';
				$date_html .= '<div class="date">' . $formatted_date . '</div>';
				$date_html .= '<div class="status">' . $status_badge . '</div>';
				$date_html .= '</div>';
			} else {
				$date_html = '<div class="date-container date-warning">';
				$date_html .= '<div class="date">Sin fecha</div>';
				$date_html .= '<div class="status"><span class="badge bg-warning">SIN FECHA</span></div>';
				$date_html .= '</div>';
			}
			
			$productDetails .= '
			<tr>
				<td><strong>ID</strong></td>
				<td>' . $product["pid"] . '</td>
			</tr>
			<tr>
				<td><strong>Nombre</strong></td>
				<td>' . $product["pname"] . '</td>
			</tr>
			<tr>
				<td><strong>Lote</strong></td>
				<td>' . $product["model"] . '</td>
			</tr>
			<tr>
				<td><strong>Fórmula</strong></td>
				<td>' . $product["description"] . '</td>
			</tr>
			<tr>
				<td><strong>Categoría</strong></td>
				<td>' . $product["name"] . '</td>
			</tr>
			<tr>
				<td><strong>Marca</strong></td>
				<td>' . $product["bname"] . '</td>
			</tr>
			<tr>
				<td><strong>Cantidad Disponible</strong></td>
				<td>' . $product["quantity"] . ' ' . $product["unit"] . ' ' . $stock_status . '</td>
			</tr>
			<tr>
				<td><strong>Fecha de Vencimiento</strong></td>
				<td>' . $date_html . '</td>
			</tr>';
		}
		$productDetails .= '
			</table>
		</div>';
		echo $productDetails;
	}


	// supplier 
	public function getSupplierList()
	{
		$sqlQuery = "SELECT * FROM " . $this->supplierTable . " ";
if (!empty($_POST["search"]["value"])) {
    $sqlQuery .= 'WHERE (supplier_name LIKE "%' . $_POST["search"]["value"] . '%" ';
    $sqlQuery .= 'OR address LIKE "%' . $_POST["search"]["value"] . '%" ) ';
}
		if (!empty($_POST["order"])) {
			$sqlQuery .= 'ORDER BY ' . $_POST['order']['0']['column'] . ' ' . $_POST['order']['0']['dir'] . ' ';
		} else {
			$sqlQuery .= 'ORDER BY supplier_id DESC ';
		}
		if ($_POST["length"] != -1) {
			$sqlQuery .= 'LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
		}
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$numRows = mysqli_num_rows($result);
		$supplierData = array();
		while ($supplier = mysqli_fetch_assoc($result)) {
			$status = '';
			if ($supplier['status'] == 'active') {
				$status = '<span class="label label-success">Active</span>';
			} else {
				$status = '<span class="label label-danger">Inactive</span>';
			}
			$supplierRows = array();
			$supplierRows[] = $supplier['supplier_id'];
			$supplierRows[] = $supplier['supplier_name'];
			$supplierRows[] = $supplier['mobile'];
			$supplierRows[] = $supplier['address'];
			$supplierRows[] = $status;
			$supplierRows[] = '<div class="btn-group btn-group-sm"><button type="button" name="update" id="' . $supplier["supplier_id"] . '" class="btn btn-primary btn-sm rounded-0  update" title="Update"><i class="fa fa-edit"></i></button><button type="button" name="delete" id="' . $supplier["supplier_id"] . '" class="btn btn-danger btn-sm rounded-0  delete"  title="Delete"><i class="fa fa-trash"></i></button></div>';
			$supplierData[] = $supplierRows;
		}
		$output = array(
			"draw"				=>	intval($_POST["draw"]),
			"recordsTotal"  	=>  $numRows,
			"recordsFiltered" 	=> 	$numRows,
			"data"    			=> 	$supplierData
		);
		echo json_encode($output);
	}
	public function addSupplier()
	{
		$sqlInsert = "
			INSERT INTO " . $this->supplierTable . "(supplier_name, mobile, address) 
			VALUES ('" . $_POST['supplier_name'] . "', '" . $_POST['mobile'] . "', '" . $_POST['address'] . "')";
		mysqli_query($this->dbConnect, $sqlInsert);
		echo 'New Supplier Added';
	}
	public function getSupplier()
	{
		$sqlQuery = "
			SELECT * FROM " . $this->supplierTable . " 
			WHERE supplier_id = '" . $_POST["supplier_id"] . "'";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
		echo json_encode($row);
	}
	public function updateSupplier()
	{
		if ($_POST['supplier_id']) {
			$sqlUpdate = "
				UPDATE " . $this->supplierTable . " 
				SET supplier_name = '" . $_POST['supplier_name'] . "', mobile= '" . $_POST['mobile'] . "' , address= '" . $_POST['address'] . "'	WHERE supplier_id = '" . $_POST['supplier_id'] . "'";
			mysqli_query($this->dbConnect, $sqlUpdate);
			echo 'Supplier Edited';
		}
	}
	public function deleteSupplier()
	{
		$sqlQuery = "
			DELETE FROM " . $this->supplierTable . " 
			WHERE supplier_id = '" . $_POST['supplier_id'] . "'";
		mysqli_query($this->dbConnect, $sqlQuery);
	}
	// purchase
	public function listPurchase() {
		try {
			$sqlQuery = "SELECT ph.*, p.pname, s.supplier_name 
						FROM " . $this->purchaseTable . " as ph
						INNER JOIN " . $this->productTable . " as p ON p.pid = ph.product_id 
						INNER JOIN " . $this->supplierTable . " as s ON s.supplier_id = ph.supplier_id ";
	
			// Búsqueda
			if (!empty($_POST["search"]["value"])) {
				$searchValue = mysqli_real_escape_string($this->dbConnect, $_POST["search"]["value"]);
				$sqlQuery .= "WHERE (ph.purchase_id LIKE '%" . $searchValue . "%' ";
				$sqlQuery .= "OR p.pname LIKE '%" . $searchValue . "%' ";
				$sqlQuery .= "OR s.supplier_name LIKE '%" . $searchValue . "%' ";
				$sqlQuery .= "OR ph.quantity LIKE '%" . $searchValue . "%') ";
			}
	
			// Total de registros sin filtrar
			$sqlTotal = "SELECT COUNT(*) as total FROM " . $this->purchaseTable;
			$resultTotal = mysqli_query($this->dbConnect, $sqlTotal);
			$rowTotal = mysqli_fetch_assoc($resultTotal);
			$totalRecords = $rowTotal['total'];
	
			// Total de registros filtrados
			$sqlFiltered = $sqlQuery;
			$resultFiltered = mysqli_query($this->dbConnect, $sqlFiltered);
			$filteredRecords = mysqli_num_rows($resultFiltered);
	
			// Ordenamiento
			if (isset($_POST['order'])) {
				$sqlQuery .= 'ORDER BY ' . $_POST['order']['0']['column'] . ' ' . $_POST['order']['0']['dir'] . ' ';
			} else {
				$sqlQuery .= 'ORDER BY ph.purchase_id DESC ';
			}
	
			// Paginación
			if ($_POST['length'] != -1) {
				$sqlQuery .= 'LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
			}
	
			$result = mysqli_query($this->dbConnect, $sqlQuery);
			$purchaseData = array();
			
			while ($purchase = mysqli_fetch_assoc($result)) {
				$productRow = array();
				$productRow[] = $purchase['purchase_id'];
				$productRow[] = $purchase['pname'];
				$productRow[] = $purchase['quantity'];
				$productRow[] = $purchase['supplier_name'];
				$productRow[] = '<div class="btn-group btn-group-sm">
								<button type="button" name="update" id="' . $purchase["purchase_id"] . '" class="btn btn-primary rounded-0 update" title="Editar">
									<i class="fa fa-edit"></i>
								</button>
								<button type="button" name="delete" id="' . $purchase["purchase_id"] . '" class="btn btn-danger rounded-0 delete" title="Eliminar">
									<i class="fa fa-trash"></i>
								</button>
							</div>';
				$purchaseData[] = $productRow;
			}
	
			$output = array(
				"draw"            => intval($_POST['draw']),
				"recordsTotal"    => $totalRecords,
				"recordsFiltered" => $filteredRecords,
				"data"            => $purchaseData
			);
	
			echo json_encode($output);
			
		} catch (Exception $e) {
			echo json_encode(array("error" => $e->getMessage()));
		}
	}
	public function productDropdownList() {
		$sqlQuery = "SELECT p.pid, p.pname, p.unit, p.quantity, c.name as category 
					 FROM " . $this->productTable . " p 
					 LEFT JOIN " . $this->categoryTable . " c ON p.categoryid = c.categoryid 
					 WHERE p.quantity > 0
					 ORDER BY p.pname ASC";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$dropdownHTML = '';
		while ($product = mysqli_fetch_assoc($result)) {
			$dropdownHTML .= sprintf(
				'<option value="%s" data-unit="%s">%s - %s (Stock: %s %s)</option>',
				$product["pid"],
				$product["unit"],
				$product["pname"],
				$product["category"],
				$product["quantity"],
				$product["unit"]
			);
		}
		return $dropdownHTML;
	}
	public function addPurchase() {
		try {
			$this->dbConnect->begin_transaction();
	
			// Insertar la compra
			$sqlInsert = "INSERT INTO " . $this->purchaseTable . "(product_id, quantity, supplier_id) 
						 VALUES (?, ?, ?)";
			$stmt = $this->dbConnect->prepare($sqlInsert);
			$stmt->bind_param("iii", $_POST['product'], $_POST['quantity'], $_POST['supplierid']);
			$stmt->execute();
	
			// Actualizar el stock del producto
			$sqlUpdate = "UPDATE " . $this->productTable . " 
						 SET quantity = quantity + ? 
						 WHERE pid = ?";
			$stmtUpdate = $this->dbConnect->prepare($sqlUpdate);
			$stmtUpdate->bind_param("ii", $_POST['quantity'], $_POST['product']);
			$stmtUpdate->execute();
	
			$this->dbConnect->commit();
			echo 'New Purchase Added';
		} catch (Exception $e) {
			$this->dbConnect->rollback();
			echo "Error: " . $e->getMessage();
		}
	}
	public function getPurchaseDetails()
	{
		$sqlQuery = "
			SELECT * FROM " . $this->purchaseTable . " 
			WHERE purchase_id = '" . $_POST["purchase_id"] . "'";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
		echo json_encode($row);
	}
	public function updatePurchase() {
		try {
			$this->dbConnect->begin_transaction();
	
			// Obtener la información de la compra actual
			$sqlQuery = "SELECT product_id, quantity FROM " . $this->purchaseTable . " 
						WHERE purchase_id = ?";
			$stmt = $this->dbConnect->prepare($sqlQuery);
			$stmt->bind_param("i", $_POST['purchase_id']);
			$stmt->execute();
			$result = $stmt->get_result();
			$oldPurchase = $result->fetch_assoc();
	
			// Revertir la cantidad anterior
			$sqlRevert = "UPDATE " . $this->productTable . " 
						 SET quantity = quantity - ? 
						 WHERE pid = ?";
			$stmtRevert = $this->dbConnect->prepare($sqlRevert);
			$stmtRevert->bind_param("ii", $oldPurchase['quantity'], $oldPurchase['product_id']);
			$stmtRevert->execute();
	
			// Actualizar la compra
			$sqlUpdate = "UPDATE " . $this->purchaseTable . " 
						 SET product_id = ?, quantity = ?, supplier_id = ? 
						 WHERE purchase_id = ?";
			$stmtUpdate = $this->dbConnect->prepare($sqlUpdate);
			$stmtUpdate->bind_param("iiii", $_POST['product'], $_POST['quantity'], $_POST['supplierid'], $_POST['purchase_id']);
			$stmtUpdate->execute();
	
			// Agregar la nueva cantidad
			$sqlAdd = "UPDATE " . $this->productTable . " 
					  SET quantity = quantity + ? 
					  WHERE pid = ?";
			$stmtAdd = $this->dbConnect->prepare($sqlAdd);
			$stmtAdd->bind_param("ii", $_POST['quantity'], $_POST['product']);
			$stmtAdd->execute();
	
			$this->dbConnect->commit();
			echo 'Purchase Updated';
		} catch (Exception $e) {
			$this->dbConnect->rollback();
			echo "Error: " . $e->getMessage();
		}
	}
	public function deletePurchase() {
		try {
			$this->dbConnect->begin_transaction();
	
			// Obtener la información de la compra antes de eliminarla
			$sqlQuery = "SELECT product_id, quantity FROM " . $this->purchaseTable . " 
						WHERE purchase_id = ?";
			$stmt = $this->dbConnect->prepare($sqlQuery);
			$stmt->bind_param("i", $_POST['purchase_id']);
			$stmt->execute();
			$result = $stmt->get_result();
			$purchase = $result->fetch_assoc();
	
			// Actualizar el stock del producto
			$sqlUpdate = "UPDATE " . $this->productTable . " 
						 SET quantity = quantity - ? 
						 WHERE pid = ?";
			$stmtUpdate = $this->dbConnect->prepare($sqlUpdate);
			$stmtUpdate->bind_param("ii", $purchase['quantity'], $purchase['product_id']);
			$stmtUpdate->execute();
	
			// Eliminar la compra
			$sqlDelete = "DELETE FROM " . $this->purchaseTable . " 
						 WHERE purchase_id = ?";
			$stmtDelete = $this->dbConnect->prepare($sqlDelete);
			$stmtDelete->bind_param("i", $_POST['purchase_id']);
			$stmtDelete->execute();
	
			$this->dbConnect->commit();
			return true;
		} catch (Exception $e) {
			$this->dbConnect->rollback();
			throw new Exception("Error al eliminar la compra: " . $e->getMessage());
		}
	}
	// order
	
	public function listOrders() {
		try {
			$sqlQuery = "SELECT o.*, c.name, p.pname, p.unit, DATE_FORMAT(o.order_date, '%d/%m/%Y %H:%i') as formatted_date 
						 FROM " . $this->orderTable . " as o
						 INNER JOIN " . $this->customerTable . " as c ON c.id = o.customer_id
						 INNER JOIN " . $this->productTable . " as p ON p.pid = o.product_id ";
	
			$whereConditions = array();
	
			// Filtro de analista (solo si se selecciona uno específico)
			if (!empty($_POST['analyzerFilter'])) {
				$whereConditions[] = "o.customer_id = '" . $_POST['analyzerFilter'] . "'";
			}
	
			// Filtros de fecha
			if (!empty($_POST['dateFromFilter'])) {
				$whereConditions[] = "DATE(o.order_date) >= '" . $_POST['dateFromFilter'] . "'";
			}
			if (!empty($_POST['dateToFilter'])) {
				$whereConditions[] = "DATE(o.order_date) <= '" . $_POST['dateToFilter'] . "'";
			}
	
			// Búsqueda global
			if (!empty($_POST["search"]["value"])) {
				$searchValue = mysqli_real_escape_string($this->dbConnect, $_POST["search"]["value"]);
				$whereConditions[] = "(o.order_id LIKE '%".$searchValue."%' OR 
									 p.pname LIKE '%".$searchValue."%' OR 
									 c.name LIKE '%".$searchValue."%' OR 
									 o.total_shipped LIKE '%".$searchValue."%')";
			}
	
			// Combinar condiciones WHERE
			if (!empty($whereConditions)) {
				$sqlQuery .= " WHERE " . implode(" AND ", $whereConditions);
			}
	
			// Total de registros sin filtrar
			$sqlTotal = "SELECT COUNT(*) as total FROM " . $this->orderTable;
			$resultTotal = mysqli_query($this->dbConnect, $sqlTotal);
			$rowTotal = mysqli_fetch_assoc($resultTotal);
			$totalRecords = $rowTotal['total'];
	
			// Total de registros filtrados
			$sqlFiltered = $sqlQuery;
			$resultFiltered = mysqli_query($this->dbConnect, $sqlFiltered);
			$filteredRecords = mysqli_num_rows($resultFiltered);
	
			// Ordenamiento
			if (isset($_POST['order'])) {
				$columns = array(
					0 => 'o.order_id',
					1 => 'p.pname',
					2 => 'o.total_shipped',
					3 => 'c.name',
					4 => 'o.order_date'
				);
				$sqlQuery .= ' ORDER BY ' . $columns[$_POST['order']['0']['column']] . ' ' . $_POST['order']['0']['dir'];
			} else {
				$sqlQuery .= ' ORDER BY o.order_id DESC';
			}
	
			// Paginación
			if ($_POST['length'] != -1) {
				$sqlQuery .= ' LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
			}
	
			$result = mysqli_query($this->dbConnect, $sqlQuery);
			$orderData = array();
			
			while ($order = mysqli_fetch_assoc($result)) {
				$orderRow = array();
				$orderRow[] = $order['order_id'];
				$orderRow[] = $order['pname'];
				$orderRow[] = $order['total_shipped'] . ' ' . $order['unit'];
				$orderRow[] = $order['name'];
				$orderRow[] = $order['formatted_date'];
				$orderRow[] = '<div class="btn-group btn-group-sm">
								
								<button type="button" name="delete" id="' . $order["order_id"] . '" class="btn btn-danger rounded-0 delete" title="Eliminar">
									<i class="fa fa-trash"></i>
								</button>
							 </div>';
				$orderData[] = $orderRow;
			}
	
			$output = array(
				"draw"              => intval($_POST["draw"]),
				"recordsTotal"      => intval($totalRecords),
				"recordsFiltered"   => intval($filteredRecords),
				"data"              => $orderData
			);
	
			echo json_encode($output);
		} catch (Exception $e) {
			echo json_encode(array("error" => $e->getMessage()));
		}
	}

	public function exportOrders($format) {
		try {
			$sqlQuery = "SELECT o.order_id, p.pname, o.total_shipped, p.unit, c.name as analyst_name, 
						 DATE_FORMAT(o.order_date, '%d/%m/%Y %H:%i') as formatted_date
						 FROM " . $this->orderTable . " as o
						 INNER JOIN " . $this->customerTable . " as c ON c.id = o.customer_id
						 INNER JOIN " . $this->productTable . " as p ON p.pid = o.product_id";
	
			$whereConditions = array();
	
			// Filtro de analista (solo si se selecciona uno específico)
			if (!empty($_POST['analyzerFilter'])) {
				$whereConditions[] = "o.customer_id = '" . $_POST['analyzerFilter'] . "'";
			}
	
			// Filtros de fecha
			if (!empty($_POST['dateFromFilter'])) {
				$whereConditions[] = "DATE(o.order_date) >= '" . $_POST['dateFromFilter'] . "'";
			}
			if (!empty($_POST['dateToFilter'])) {
				$whereConditions[] = "DATE(o.order_date) <= '" . $_POST['dateToFilter'] . "'";
			}
	
			// Búsqueda global
			if (!empty($_POST['search']['value'])) {
				$searchValue = mysqli_real_escape_string($this->dbConnect, $_POST['search']['value']);
				$whereConditions[] = "(o.order_id LIKE '%".$searchValue."%' OR 
									 p.pname LIKE '%".$searchValue."%' OR 
									 c.name LIKE '%".$searchValue."%' OR 
									 o.total_shipped LIKE '%".$searchValue."%')";
			}
	
			if (!empty($whereConditions)) {
				$sqlQuery .= " WHERE " . implode(" AND ", $whereConditions);
			}
	
			$sqlQuery .= " ORDER BY o.order_id DESC";
			
			$result = mysqli_query($this->dbConnect, $sqlQuery);
			$data = array();
	
			while ($row = mysqli_fetch_assoc($result)) {
				$data[] = array(
					'ID' => $row['order_id'],
					'Producto' => $row['pname'],
					'Cantidad' => $row['total_shipped'] . ' ' . $row['unit'],
					'Analista' => $row['analyst_name'],
					'Fecha' => $row['formatted_date']
				);
			}
	
			return $data;
		} catch (Exception $e) {
			throw new Exception("Error en exportación: " . $e->getMessage());
		}
	}

	/*public function addOrder()
	{
		$sqlInsert = "
			INSERT INTO " . $this->orderTable . "(product_id, total_shipped, customer_id) 
			VALUES ('" . $_POST['product'] . "', '" . $_POST['shipped'] . "', '" . $_POST['customer'] . "')";
		mysqli_query($this->dbConnect, $sqlInsert);
		echo 'New order added';
	}*/
	public function getOrderDetails() {
		try {
			// Obtener detalles de la orden
			$sqlQuery = "SELECT o.*, p.unit 
						FROM " . $this->orderTable . " o
						LEFT JOIN " . $this->productTable . " p ON o.product_id = p.pid
						WHERE o.order_id = ?";
			
			$stmt = $this->dbConnect->prepare($sqlQuery);
			$stmt->bind_param("i", $_POST["order_id"]);
			$stmt->execute();
			$result = $stmt->get_result();
			$row = $result->fetch_array(MYSQLI_ASSOC);
			
			// Construir opciones de productos
			$sqlProducts = "SELECT p.pid, p.pname, p.unit, p.quantity, c.name as category 
						   FROM " . $this->productTable . " p 
						   LEFT JOIN " . $this->categoryTable . " c ON p.categoryid = c.categoryid 
						   ORDER BY p.pname ASC";
			
			$resultProducts = mysqli_query($this->dbConnect, $sqlProducts);
			$productOptions = '<option value="">Buscar producto...</option>';
			
			while ($product = mysqli_fetch_assoc($resultProducts)) {
				$selected = ($product['pid'] == $row['product_id']) ? 'selected' : '';
				$productOptions .= sprintf(
					'<option value="%s" data-unit="%s" %s>%s - %s (Stock: %s %s)</option>',
					$product["pid"],
					$product["unit"],
					$selected,
					$product["pname"],
					$product["category"],
					$product["quantity"],
					$product["unit"]
				);
			}
			
			$row['product_options'] = $productOptions;
			
			echo json_encode($row);
		} catch (Exception $e) {
			echo json_encode(array("error" => $e->getMessage()));
		}
	}
	/*public function updateOrder()
	{
		if ($_POST['order_id']) {
			$sqlUpdate = "
				UPDATE " . $this->orderTable . " 
				SET product_id = '" . $_POST['product'] . "', total_shipped='" . $_POST['shipped'] . "', customer_id='" . $_POST['customer'] . "' WHERE order_id = '" . $_POST['order_id'] . "'";
			mysqli_query($this->dbConnect, $sqlUpdate);
			echo 'Order Edited';
		}
	} */
	public function deleteOrder() {
		try {
			// Iniciamos una transacción
			$this->dbConnect->begin_transaction();
	
			// Primero obtenemos la información de la orden antes de eliminarla
			$sqlQuery = "SELECT product_id, total_shipped FROM " . $this->orderTable . " WHERE order_id = ?";
			$stmt = $this->dbConnect->prepare($sqlQuery);
			$stmt->bind_param("i", $_POST['order_id']);
			$stmt->execute();
			$result = $stmt->get_result();
			$order = $result->fetch_assoc();
	
			if($order) {
				// Actualizamos el stock devolviendo la cantidad
				$sqlUpdate = "UPDATE " . $this->productTable . " 
							 SET quantity = quantity + ? 
							 WHERE pid = ?";
				$stmtUpdate = $this->dbConnect->prepare($sqlUpdate);
				$stmtUpdate->bind_param("ii", $order['total_shipped'], $order['product_id']);
				$stmtUpdate->execute();
	
				// Eliminamos la orden
				$sqlDelete = "DELETE FROM " . $this->orderTable . " WHERE order_id = ?";
				$stmtDelete = $this->dbConnect->prepare($sqlDelete);
				$stmtDelete->bind_param("i", $_POST['order_id']);
				$stmtDelete->execute();
	
				// Si todo salió bien, confirmamos la transacción
				$this->dbConnect->commit();
				
				return true;
			}
	
		} catch (Exception $e) {
			// Si algo sale mal, revertimos los cambios
			$this->dbConnect->rollback();
			throw new Exception("Error al eliminar la orden: " . $e->getMessage());
		}
	}
	public function customerDropdownList()
	{
		$sqlQuery = "SELECT * FROM " . $this->customerTable . " ORDER BY name ASC";
		$result = mysqli_query($this->dbConnect, $sqlQuery);
		$dropdownHTML = '';
		while ($customer = mysqli_fetch_assoc($result)) {
			$dropdownHTML .= '<option value="' . $customer["id"] . '">' . $customer["name"] . '</option>';
		}
		return $dropdownHTML;
	}
	// Nueva función para obtener las opciones del filtro de categorías
public function getCategoryFilterOptions() {
    $sqlQuery = "SELECT categoryid, name FROM " . $this->categoryTable . " WHERE status = 'active' ORDER BY name ASC";
    $result = mysqli_query($this->dbConnect, $sqlQuery);
    $categoryOptions = '';
    while ($category = mysqli_fetch_assoc($result)) {
        $categoryOptions .= '<option value="' . $category['categoryid'] . '">' . $category['name'] . '</option>';
    }
    return $categoryOptions;
}

public function exportInventory($format) {
    try {
        $sqlQuery = "SELECT p.pid, p.pname, p.description, p.model, p.quantity as product_quantity, 
                     p.date, p.unit, c.name as category_name, b.bname as brand_name 
                     FROM " . $this->productTable . " as p
                     LEFT JOIN " . $this->categoryTable . " as c ON p.categoryid = c.categoryid
                     LEFT JOIN " . $this->brandTable . " as b ON p.brandid = b.id";

        $whereConditions = array();

        // Aplicar filtros si existen
        if (!empty($_POST['categoryFilter'])) {
            $whereConditions[] = "p.categoryid = '" . $_POST['categoryFilter'] . "'";
        }

        if (!empty($_POST['stockFilter'])) {
            switch ($_POST['stockFilter']) {
                case 'ok':
                    $whereConditions[] = "p.quantity > 10";
                    break;
                case 'bajo':
                    $whereConditions[] = "p.quantity <= 10 AND p.quantity > 5";
                    break;
                case 'critico':
                    $whereConditions[] = "p.quantity <= 5 AND p.quantity > 0";
                    break;
                case 'sin_stock':
                    $whereConditions[] = "p.quantity <= 0";
                    break;
            }
        }

        if (!empty($_POST['expirationFilter'])) {
            $today = date('Y-m-d');
            $threeMonthsLater = date('Y-m-d', strtotime('+3 months'));
            
            switch ($_POST['expirationFilter']) {
                case 'ok':
                    $whereConditions[] = "p.date > '$threeMonthsLater'";
                    break;
                case 'proximo':
                    $whereConditions[] = "p.date <= '$threeMonthsLater' AND p.date > '$today'";
                    break;
                case 'vencido':
                    $whereConditions[] = "p.date <= '$today'";
                    break;
            }
        }

        if (!empty($_POST['search']['value'])) {
            $searchValue = mysqli_real_escape_string($this->dbConnect, $_POST['search']['value']);
            $whereConditions[] = "(p.pid LIKE '%".$searchValue."%' OR 
                                 p.pname LIKE '%".$searchValue."%' OR 
                                 p.description LIKE '%".$searchValue."%' OR 
                                 p.model LIKE '%".$searchValue."%' OR 
                                 c.name LIKE '%".$searchValue."%')";
        }

        if (!empty($whereConditions)) {
            $sqlQuery .= " WHERE " . implode(" AND ", $whereConditions);
        }

        $sqlQuery .= " ORDER BY p.pid";
        
        $result = mysqli_query($this->dbConnect, $sqlQuery);
        $data = array();

        while ($row = mysqli_fetch_assoc($result)) {
            // Determinar estado del stock
            if ($row['product_quantity'] > 10) {
                $stockStatus = "OK";
            } elseif ($row['product_quantity'] > 5) {
                $stockStatus = "BAJO";
            } elseif ($row['product_quantity'] > 0) {
                $stockStatus = "CRÍTICO";
            } else {
                $stockStatus = "SIN STOCK";
            }

            // Calcular estado de fecha
            $dateStatus = "SIN FECHA";
            $formattedDate = "Sin fecha";
            
            if (!empty($row['date']) && $row['date'] != '0000-00-00') {
                $current_date = new DateTime();
                $current_date->setTime(0, 0, 0);
                $product_date = new DateTime($row['date']);
                $product_date->setTime(0, 0, 0);
                
                $interval = $current_date->diff($product_date);
                $days_difference = $interval->days * ($interval->invert ? -1 : 1);
                $formattedDate = $product_date->format('d/m/Y');

                if ($days_difference <= 0) {
                    $dateStatus = "VENCIDO";
                } elseif ($days_difference <= 90) {
                    $dateStatus = "PRÓXIMO A VENCER";
                } else {
                    $dateStatus = "OK";
                }
            }

            $data[] = array(
                'ID' => $row['pid'],
                'Producto' => $row['pname'],
                'Lote' => $row['model'],
                'Fórmula' => $row['description'],
                'Marca' => $row['brand_name'],
                'Categoría' => $row['category_name'],
                'Cantidad' => $row['product_quantity'],
                'Unidad' => $row['unit'],
                'Estado Stock' => $stockStatus,
                'Fecha Vencimiento' => $formattedDate . ' - ' . $dateStatus
            );
        }

        return $data;
    } catch (Exception $e) {
        throw new Exception("Error en exportación: " . $e->getMessage());
    }
}


public function getInventoryDetails() {
    try {
        // Determinar si es una solicitud de exportación
        $isExport = isset($_POST['export']) && $_POST['export'] === 'true';

        $sqlQuery = "SELECT p.pid, p.pname, p.description, p.model, p.quantity as product_quantity, 
             p.date, p.unit, c.name as category_name, b.bname as brand_name 
             FROM " . $this->productTable . " as p
             LEFT JOIN " . $this->categoryTable . " as c ON p.categoryid = c.categoryid
             LEFT JOIN " . $this->brandTable . " as b ON p.brandid = b.id";

        $whereConditions = array();

        // Búsqueda global
        if (!empty($_POST["search"]["value"])) {
            $searchValue = mysqli_real_escape_string($this->dbConnect, $_POST["search"]["value"]);
            $whereConditions[] = "(p.pid LIKE '%" . $searchValue . "%' 
                                OR p.pname LIKE '%" . $searchValue . "%'
                                OR p.description LIKE '%" . $searchValue . "%'
                                OR p.model LIKE '%" . $searchValue . "%'
                                OR c.name LIKE '%" . $searchValue . "%'
                                OR p.quantity LIKE '%" . $searchValue . "%'
                                OR p.unit LIKE '%" . $searchValue . "%'
                                OR p.date LIKE '%" . $searchValue . "%')";
        }

        // Filtro de categoría
        if (!empty($_POST['categoryFilter'])) {
            $whereConditions[] = "p.categoryid = '" . $_POST['categoryFilter'] . "'";
        }

        // Filtro de stock
        if (!empty($_POST['stockFilter'])) {
            switch ($_POST['stockFilter']) {
                case 'ok':
                    $whereConditions[] = "p.quantity > 10";
                    break;
                case 'bajo':
                    $whereConditions[] = "p.quantity <= 10 AND p.quantity > 5";
                    break;
                case 'critico':
                    $whereConditions[] = "p.quantity <= 5 AND p.quantity > 0";
                    break;
                case 'sin_stock':
                    $whereConditions[] = "p.quantity <= 0";
                    break;
            }
        }

        // Filtro de vencimiento
        if (!empty($_POST['expirationFilter'])) {
            $today = date('Y-m-d');
            $threeMonthsLater = date('Y-m-d', strtotime('+3 months'));
            
            switch ($_POST['expirationFilter']) {
                case 'ok':
                    $whereConditions[] = "p.date > '$threeMonthsLater'";
                    break;
                case 'proximo':
                    $whereConditions[] = "p.date <= '$threeMonthsLater' AND p.date > '$today'";
                    break;
                case 'vencido':
                    $whereConditions[] = "p.date <= '$today'";
                    break;
            }
        }

        // Combinar condiciones WHERE
        if (!empty($whereConditions)) {
            $sqlQuery .= " WHERE " . implode(" AND ", $whereConditions);
        }

        // Obtener el total de registros sin filtrar
        $sqlTotal = "SELECT COUNT(*) as total FROM " . $this->productTable;
        $resultTotal = mysqli_query($this->dbConnect, $sqlTotal);
        $rowTotal = mysqli_fetch_assoc($resultTotal);
        $totalRecords = $rowTotal['total'];

        // Obtener el total de registros filtrados
        $sqlFiltered = $sqlQuery;
        $resultFiltered = mysqli_query($this->dbConnect, $sqlFiltered);
        $totalFiltered = mysqli_num_rows($resultFiltered);

        // Ordenamiento
        if (isset($_POST['order']) && !$isExport) {
            $columnIndex = $_POST['order']['0']['column'];
            $columnName = $_POST['columns'][$columnIndex]['data'];
            $columnSortOrder = $_POST['order']['0']['dir'];
            
            $columnsMap = [
                0 => 'p.pid',
                1 => 'p.pname',
                2 => 'c.name',
                3 => 'p.quantity'
            ];
            
            if(isset($columnsMap[$columnIndex])) {
                $sqlQuery .= " ORDER BY " . $columnsMap[$columnIndex] . " " . $columnSortOrder;
            }
        } else {
            $sqlQuery .= " ORDER BY p.pid DESC";
        }

        // Aplicar paginación solo si no es una exportación
        if (!$isExport && isset($_POST["start"]) && isset($_POST["length"])) {
            $sqlQuery .= " LIMIT " . $_POST["start"] . ", " . $_POST["length"];
        }

        $result = mysqli_query($this->dbConnect, $sqlQuery);
        $inventoryData = array();
        
        while ($inventory = mysqli_fetch_assoc($result)) {
            // Estado del stock
            $stock_status = '';
            $quantity = $inventory['product_quantity'];

            if ($quantity > 10) {
                $stock_status = '<span class="badge bg-success">OK</span>';
            } elseif ($quantity > 5) {
                $stock_status = '<span class="badge bg-warning">BAJO</span>';
            } elseif ($quantity > 0) {
                $stock_status = '<span class="badge bg-orange" style="background-color: #fd7e14;">CRÍTICO</span>';
            } else {
                $stock_status = '<span class="badge bg-danger">SIN STOCK</span>';
            }

            // Estado de la fecha de vencimiento
            $date_class = '';
            $status_text = '';
            
            if (!empty($inventory['date']) && $inventory['date'] != '0000-00-00') {
                $current_date = new DateTime();
                $current_date->setTime(0, 0, 0);
                $product_date = new DateTime($inventory['date']);
                $product_date->setTime(0, 0, 0);
                
                $interval = $current_date->diff($product_date);
                $days_difference = $interval->days * ($interval->invert ? -1 : 1);
                $formatted_date = $product_date->format('d/m/Y');

                if ($days_difference <= 0) {
                    $date_class = 'date-expired';
                    $status_text = '<span class="badge bg-danger">VENCIDO</span>';
                } elseif ($days_difference <= 90) {
                    $date_class = 'date-warning';
                    $status_text = '<span class="badge bg-orange" style="background-color: #fd7e14;">PRÓXIMO A VENCER</span>';
                } else {
                    $date_class = 'date-ok';
                    $status_text = '<span class="badge bg-success">OK</span>';
                }
            } else {
                $formatted_date = 'Sin fecha';
                $date_class = 'date-warning';
                $status_text = '<span class="badge bg-warning">SIN FECHA</span>';
            }
            
            $date_html = '<div class="text-center">';
            $date_html .= '<div class="date-container ' . $date_class . '">';
            $date_html .= '<div class="date">' . $formatted_date . '</div>';
            $date_html .= '<div class="status">' . $status_text . '</div>';
            $date_html .= '</div>';
            $date_html .= '</div>';
            
            $inventoryRow = array();
            $inventoryRow[] = $inventory['pid'];
            $inventoryRow[] = $inventory['pname'];
            $inventoryRow[] = $inventory['model'];
            $inventoryRow[] = $inventory['description'];
            $inventoryRow[] = $inventory['brand_name'];
            $inventoryRow[] = $inventory['category_name'];
            $inventoryRow[] = $inventory['product_quantity'];
            $inventoryRow[] = $inventory['unit'];
            $inventoryRow[] = '<div class="text-center">' . $stock_status . '</div>';
            $inventoryRow[] = $date_html;
            $inventoryData[] = $inventoryRow;
        }

        $output = array(
            "draw" => isset($_POST['draw']) ? intval($_POST['draw']) : 0,
            "recordsTotal" => $totalRecords,
            "recordsFiltered" => $totalFiltered,
            "data" => $inventoryData
        );

        echo json_encode($output);
    } catch (Exception $e) {
        echo json_encode(array("error" => $e->getMessage()));
    }
}


// Stock Verification Methods
public function getProductStock($productId) {
    $sqlQuery = "SELECT quantity FROM ".$this->productTable." WHERE pid = ?";
    $stmt = $this->dbConnect->prepare($sqlQuery);
    $stmt->bind_param("i", $productId);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    return $row['quantity'] ?? 0;
}

public function verifyStock($productId, $requestedQuantity) {
    $availableStock = $this->getProductStock($productId);
    
    if ($requestedQuantity > $availableStock) {
        return array(
            'status' => 'error',
            'message' => "No hay suficiente stock. Stock disponible: " . $availableStock,
            'available' => $availableStock
        );
    }
    
    return array(
        'status' => 'success',
        'message' => 'Stock disponible',
        'available' => $availableStock
    );
}

public function addOrder() {
    // Primero verificamos el stock
    $stockCheck = $this->verifyStock($_POST['product'], $_POST['shipped']);
    if ($stockCheck['status'] === 'error') {
        echo 'Error: ' . $stockCheck['message'];
        return;
    }

    // Si hay stock suficiente, procedemos con la orden
    $sqlInsert = "
        INSERT INTO ".$this->orderTable."(product_id, total_shipped, customer_id) 
        VALUES (?, ?, ?)";
    
    $stmt = $this->dbConnect->prepare($sqlInsert);
    $stmt->bind_param("iii", $_POST['product'], $_POST['shipped'], $_POST['customer']);
    
    if ($stmt->execute()) {
        // Actualizamos el stock del producto
        $sqlUpdate = "UPDATE ".$this->productTable." 
                     SET quantity = quantity - ? 
                     WHERE pid = ?";
        $stmtUpdate = $this->dbConnect->prepare($sqlUpdate);
        $stmtUpdate->bind_param("ii", $_POST['shipped'], $_POST['product']);
        $stmtUpdate->execute();
        
        echo 'New order added';
    } else {
        echo 'Error adding order';
    }
}

public function updateOrder() {
    if($_POST['order_id']) {
        // Obtenemos la orden actual
        $sqlQuery = "SELECT * FROM ".$this->orderTable." WHERE order_id = ?";
        $stmt = $this->dbConnect->prepare($sqlQuery);
        $stmt->bind_param("i", $_POST['order_id']);
        $stmt->execute();
        $result = $stmt->get_result();
        $oldOrder = $result->fetch_assoc();
        
        // Calculamos la diferencia de cantidad
        $quantityDiff = $_POST['shipped'] - $oldOrder['total_shipped'];
        
        // Si es el mismo producto, verificamos el stock para la diferencia
        if ($oldOrder['product_id'] == $_POST['product'] && $quantityDiff > 0) {
            $stockCheck = $this->verifyStock($_POST['product'], $quantityDiff);
            if ($stockCheck['status'] === 'error') {
                echo 'Error: ' . $stockCheck['message'];
                return;
            }
        }
        
        // Si es un producto diferente, verificamos el stock completo
        if ($oldOrder['product_id'] != $_POST['product']) {
            $stockCheck = $this->verifyStock($_POST['product'], $_POST['shipped']);
            if ($stockCheck['status'] === 'error') {
                echo 'Error: ' . $stockCheck['message'];
                return;
            }
        }

        // Actualizamos la orden
        $sqlUpdate = "
            UPDATE ".$this->orderTable." 
            SET product_id = ?, total_shipped = ?, customer_id = ? 
            WHERE order_id = ?";
        
        $stmt = $this->dbConnect->prepare($sqlUpdate);
        $stmt->bind_param("iiii", $_POST['product'], $_POST['shipped'], $_POST['customer'], $_POST['order_id']);
        
        if ($stmt->execute()) {
            // Si es el mismo producto, actualizamos la diferencia
            if ($oldOrder['product_id'] == $_POST['product']) {
                $sqlUpdateStock = "UPDATE ".$this->productTable." 
                                 SET quantity = quantity - ? 
                                 WHERE pid = ?";
                $stmtStock = $this->dbConnect->prepare($sqlUpdateStock);
                $stmtStock->bind_param("ii", $quantityDiff, $_POST['product']);
                $stmtStock->execute();
            } else {
                // Si es un producto diferente, devolvemos el stock al producto anterior
                $sqlUpdateOldStock = "UPDATE ".$this->productTable." 
                                    SET quantity = quantity + ? 
                                    WHERE pid = ?";
                $stmtOldStock = $this->dbConnect->prepare($sqlUpdateOldStock);
                $stmtOldStock->bind_param("ii", $oldOrder['total_shipped'], $oldOrder['product_id']);
                $stmtOldStock->execute();
                
                // Y reducimos el stock del nuevo producto
                $sqlUpdateNewStock = "UPDATE ".$this->productTable." 
                                    SET quantity = quantity - ? 
                                    WHERE pid = ?";
                $stmtNewStock = $this->dbConnect->prepare($sqlUpdateNewStock);
                $stmtNewStock->bind_param("ii", $_POST['shipped'], $_POST['product']);
                $stmtNewStock->execute();
            }
            
            echo 'Order Updated';
        }
    }
}

}
