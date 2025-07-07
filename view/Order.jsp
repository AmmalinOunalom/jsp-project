<%@ page import="model.Product" %>
<form action="order" method="post">
    Product 1:
    <input type="hidden" name="product_id" value="1" />
    Quantity: <input type="number" name="quantity" value="1" />
    Price: <input type="text" name="price" value="100.0" /><br/>

    Product 2:
    <input type="hidden" name="product_id" value="2" />
    Quantity: <input type="number" name="quantity" value="2" />
    Price: <input type="text" name="price" value="80.0" /><br/>

    <input type="submit" value="Place Order" />
</form>
