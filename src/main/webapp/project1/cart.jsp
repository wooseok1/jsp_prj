<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<meta charset="UTF-8">
<title>��ٱ��� - �ѷ��긣</title>
<!-- bootstrap CDN ����-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- JQuery CDN ����-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f5f5f5;
        color: #333;
    }
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .cart_table {
        width: 100%;
        border-collapse: collapse;
        background-color: #fff;
        margin-bottom: 20px;
    }
    .cart_table th, .cart_table td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }
    .cart_table th {
        background-color: #e8e8e1;
    }
    .cart_table img {
        max-width: 80px;
        height: auto;
    }
    
    .quantity_control {
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .quantity_control button {
        background-color: #f0f0f0;
        border: 1px solid #ddd;
        padding: 5px 10px;
        cursor: pointer;
    }
    .quantity_control input {
        width: 40px;
        text-align: center;
        margin: 0 5px;
        border: 1px solid #ddd;
    }
    
    .total_order {
        background-color: #fff;
        padding: 20px;
        margin-bottom: 20px;
        text-align: right;
        border: 1px solid #ddd;
    }
    .total_order strong {
        font-size: 18px;
        color: #1d4627;
    }
    
    .buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
    }
    .buttons button {
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border: none;
        margin-left: 10px;
    }
    .btn_brown {
        background-color: #8b6037;
        color: white;
    }
    .btn_white {
        background-color: white;
        border: 1px solid #8b6037;
        color: #8b6037;
    }
    .btn_green {
        background-color: #1d4627;
        color: white;
    }
    .order_steps_image {
        width: 100%;
        max-width: 1200px;
        height: auto;
        margin-bottom: 20px;
    }
    .product_info {
        display: flex;
        align-items: center;
        text-align: left;
    }
    .product_info img {
        max-width: 80px;
        height: auto;
        margin-right: 10px;
    }
    .product_info p {
        margin: 0;
    }
</style>
<script type="text/javascript">
$(function(){
	 // ���� ���� �� �ݾ� ���
    $('.quantity_control button').click(function() {
        var row = $(this).closest('tr');
        var input = row.find('input[type="text"]');
        var quantity = parseInt(input.val());
        
        if ($(this).text() === '+') {
            quantity++;
        } else if (quantity > 1) {
            quantity--;
        }
        
        input.val(quantity);
        updateRowTotal(row);
        updateTotalOrder();
    });

    // ��ü ����/����
    $('#selectAll').change(function() {
        $('.cart_table tbody input[type="checkbox"]').prop('checked', $(this).prop('checked'));
        updateTotalOrder();
    });

    // ���� üũ�ڽ� ���� ��
    $('.cart_table tbody input[type="checkbox"]').change(function() {
        updateSelectAllCheckbox();
        updateTotalOrder();
    });

    function updateRowTotal(row) {
        var price = parseInt(row.find('td:eq(2)').text().replace(/[^0-9]/g, ''));
        var quantity = parseInt(row.find('input[type="text"]').val());
        var total = price * quantity;
        row.find('td:eq(4)').text(total.toLocaleString() + '��');
    }

    function updateTotalOrder() {
        var total = 0;
        $('.cart_table tbody tr').each(function() {
            if ($(this).find('input[type="checkbox"]').prop('checked')) {
                total += parseInt($(this).find('td:eq(4)').text().replace(/[^0-9]/g, ''));
            }
        });
        var shipping = 5000;
        var grandTotal = total + shipping;
        $('.total_order').html('�ֹ��ݾ� �հ� ' + total.toLocaleString() + '�� + ��ۺ� ' + shipping.toLocaleString() + '�� = �� �ֹ��ݾ� <strong>' + grandTotal.toLocaleString() + '��</strong>');
    }

    // ���� �߰��� �Լ�: ���� üũ�ڽ� ���¿� ���� ��ü ���� üũ�ڽ� ������Ʈ
    function updateSelectAllCheckbox() {
        var allChecked = $('.cart_table tbody input[type="checkbox"]').length === 
                         $('.cart_table tbody input[type="checkbox"]:checked').length;
        $('#selectAll').prop('checked', allChecked);
    }
});
</script>
</head>
<body>
    <div class="container">
        <img src="common/img/��ٱ���1.png" alt="�ֹ� �ܰ�" class="order_steps_image">
        <table class="cart_table">
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll" checked></th>
                    <th>��ǰ����</th>
                    <th>�ֹ��ݾ�</th>
                    <th>����</th>
                    <th>�ݾ�</th>
                    <th>��ۺ�</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input type="checkbox" checked></td>
                    <td>
                        <div class="product_info">
                            <img src="common/img/��������ұݹ��ͽĻ�.jpg" alt="��������ұݹ��ͽĻ�">
                            <p>��������ұݹ��ͽĻ�</p>
                        </div>
                    </td>
                    <td>9,000��</td>
                    <td>
                        <div class="quantity_control">
                            <button>-</button>
                            <input type="text" value="1">
                            <button>+</button>
                        </div>
                    </td>
                    <td>9,000��</td>
                    <td rowspan="2">5,000��</td>
                </tr>
                <tr>
                    <td><input type="checkbox" checked></td>
                    <td>
                        <div class="product_info">
                            <img src="common/img/���ڻ�ũ������ũ.jpg" alt="���ڻ�ũ������ũ">
                            <p>���ڻ�ũ������ũ</p>
                        </div>
                    </td>
                    <td>25,000��</td>
                    <td>
                        <div class="quantity_control">
                            <button>-</button>
                            <input type="text" value="1">
                            <button>+</button>
                        </div>
                    </td>
                    <td>25,000��</td>
                </tr>
            </tbody>
        </table>
        
        <div class="total_order">
            �ֹ��ݾ� �հ� 34,000�� + ��ۺ� 5,000�� = �� �ֹ��ݾ� <strong>39,000��</strong>
        </div>
        
        <div class="buttons">
            <div>
                <button class="btn_brown">���û���</button>
            </div>
            <div>
                <button class="btn_white">���ΰ���ϱ�</button>
                <button class="btn_green">��ü��ǰ �ֹ�</button>
                <button class="btn_green">���û�ǰ �ֹ�</button>
            </div>
        </div>
    </div>
</body>
</html>