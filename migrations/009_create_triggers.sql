CREATE OR REPLACE FUNCTION update_lowest_price()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.actual_price < OLD.lowest_price_30 OR OLD.lowest_price_30 IS NULL THEN
        NEW.lowest_price_30 := NEW.actual_price;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_lowest_price_trigger
BEFORE UPDATE ON Products
FOR EACH ROW
EXECUTE FUNCTION update_lowest_price();

 -- simplified logic assuming you have order_items table
CREATE OR REPLACE FUNCTION update_inventory_on_order()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        -- For example, let's assume order contains only one item and order contains product_id and size
          UPDATE Inventory SET stock_quantity = stock_quantity - 1 WHERE product_id = NEW.product_id AND size = NEW.size;
    ELSIF TG_OP = 'UPDATE' THEN
          UPDATE Inventory SET stock_quantity = stock_quantity - 1 WHERE product_id = NEW.product_id AND size = NEW.size;
    END IF;
     RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_inventory_on_order_trigger
AFTER INSERT OR UPDATE ON Orders
FOR EACH ROW
EXECUTE FUNCTION update_inventory_on_order();


CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER set_updated_at_trigger
BEFORE UPDATE ON Invoices
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

CREATE OR REPLACE FUNCTION prevent_duplicate_opinions()
RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM Opinions
    WHERE product_id = NEW.product_id AND customer_id = NEW.customer_id
  ) THEN
    RAISE EXCEPTION 'Customer cannot add multiple opinions for the same product.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER prevent_duplicate_opinions_trigger
BEFORE INSERT ON Opinions
FOR EACH ROW
EXECUTE FUNCTION prevent_duplicate_opinions();