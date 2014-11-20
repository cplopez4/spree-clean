class ToolsController < ApplicationController
	def export_xls
		@orders = JSON.parse(params[:orders]) || []

		@orders.each do |order|
			case order['payment_state']
			when "paid"    
			  	order['payment_state'] = "PAGADO" 
			when "void"    
			  	order['payment_state'] = "CANCELADO"
			when "credit_owed"
				order['payment_state'] = "DEBE CREDITO"
			when "balance_due"
				order['payment_state'] = "DEBE PAGO"
			else
			  	order['payment_state'] = "S/I"
			end

			shipments = Spree::Order.find(order['id']).shipments rescue []

			if(shipments.length > 0)
				order['shipping_method'] = shipments.first.shipping_method.name rescue ""
				order['items'] = []

				shipments.first.line_items.each do |line|
					obj = {}
					obj['name_fix'] = line.variant.product.name rescue ""
					obj['total'] = line.price
					obj['quantity'] = line.quantity
					order['items'] << obj
				end
			end

			if(order['ship_address_id'])
				address = Spree::Address.find(order['ship_address_id'])
				order['ship_name'] = address.firstname + " " + address.lastname
				order['ship_address'] = address.address1
				order['ship_city'] = address.city
			end

			if(order['completed_at'])
				datetime = DateTime.parse(order['completed_at'])
				order['fix_date'] = datetime.strftime("%d/%m/%y")
			else
				datetime = DateTime.parse(order['created_at'])
				order['fix_date'] = datetime.strftime("%d/%m/%y")
			end
		end

		respond_to do |format|
	      format.xls { headers["Content-Disposition"] = "attachment; filename=\"ordenes_del_dia.xls\"" }
	    end
	end

	def export_xls_correos
		@orders = JSON.parse(params[:orders]) || []

		@orders.each do |order|
			if(order['ship_address_id'])
				address = Spree::Address.find(order['ship_address_id'])
				order['ship_name'] = address.firstname + " " + address.lastname
				order['ship_address'] = address.address1
				order['ship_city'] = address.city
			end

			if(order['bill_address_id'])
				address = Spree::Address.find(order['bill_address_id'])
				order['bill_address'] = address.address1
				order['bill_city'] = address.city
				if(order['user_id'])
					order['bill_email'] = Spree::User.find(order['user_id']).email
				else
					order['bill_email'] = order['email']
				end
				order['bill_phone'] = address.phone
			end
		end

		respond_to do |format|
	      format.xls { headers["Content-Disposition"] = "attachment; filename=\"ordenes_correos.xls\"" }
	    end
	end

	def export_xls_chilexpress
		@orders = JSON.parse(params[:orders]) || []

		@orders.each do |order|
			if(order['ship_address_id'])
				address = Spree::Address.find(order['ship_address_id'])
				order['ship_name'] = address.firstname + " " + address.lastname
				order['ship_address'] = address.address1
				order['ship_city'] = address.city
				order['ship_zipcode'] = address.zipcode
				order['ship_phone'] = address.phone
			end
		end

		respond_to do |format|
	      format.xls { headers["Content-Disposition"] = "attachment; filename=\"ordenes_chilexpress.xls\"" }
	    end
	end
end
