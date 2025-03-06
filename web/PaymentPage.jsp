<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Page</title>
    <style>
       body {
            font-family: Arial, sans-serif;
            background-image: url('bg4.jpg');
            background-repeat: no-repeat;
            background-size: cover; 
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            color: #333;
        }
        p {
            font-size: 1.2em;
            margin-bottom: 20px;
        }
        .qr-code {
            margin-bottom: 20px;
            display: none; 
        }
        .pay-text {
            padding: 10px 20px;
            background-color: navy;
            color: white;
            border-radius: 4px;
            cursor: not-allowed;
            font-size: 1.2em;
            display: inline-block;
        }
        .back-menu-btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: navy;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 1.2em;
            display: inline-block;
        }
        .back-menu-btn:hover {
            background-color: #B8001F;
        }
        .loader {
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid navy;
            width: 80px;
            height: 80px;
            animation: spin 2s linear infinite;
            margin: 20px auto;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .thank-you {
            font-size: 1.4em;
            color: green;
            margin-top: 20px;
            display: none; 
        }
        .download-btn {
            display: none; 
            margin-top: 20px;
            padding: 10px 20px;
            background-color: navy;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .download-btn:hover {
            background-color: #B8001F;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Pay Your Bill</h1>
        <p>Customer ID: <%= request.getParameter("customer_id") %></p>
        <p>Amount: ₹<%= request.getParameter("amount") %></p>

        <div class="loader" id="loader"></div>

        <div class="qr-code" id="qr-code">
            <img src="qr1.jpg" alt="QR Code" width="150">
        </div>
        
        <a href="customer.jsp" class="back-menu-btn">Back to Menu</a>

        <p class="thank-you" id="thank-you">Thank you for your payment!</p>

        <a id="download-receipt" class="download-btn" href="#" download="receipt.txt">Download Receipt</a>

    </div>

    <script>
        window.onload = function() {
           
            setTimeout(function() {
                document.getElementById('loader').style.display = 'none'; 
                document.getElementById('qr-code').style.display = 'block'; 
            }, 3000); 
        };

        
        setTimeout(function() {
            document.getElementById('thank-you').style.display = 'block'; 
            document.getElementById('download-receipt').style.display = 'inline-block';

            
            const receiptData = `Receipt for Payment\n\nCustomer ID: <%= request.getParameter("customer_id") %>\nAmount Paid: ₹<%= request.getParameter("amount") %>\nThank you for your payment!`;
            const receiptBlob = new Blob([receiptData], { type: 'text/plain' });
            const receiptUrl = URL.createObjectURL(receiptBlob);

           
            document.getElementById('download-receipt').href = receiptUrl;
        }, 6000); 
    </script>
</body>
</html>
