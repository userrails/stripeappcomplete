class PaymentsController < ApplicationController
	def new
	 @payment = Payment.new
	end

	def create
		@payment = Payment.new(payment_params)
		if @payment.save

	      customer = Stripe::Customer.create(
	        :card  => params[:payment][:stripe_card_token]
	      )
    
	      @payment.update(:stripe_customer_id => customer.id, :stripe_card_token => params[:payment][:stripe_card_token] )
	      charge = Stripe::Charge.create(
	        :customer    => customer.id,
	        :amount      => @payment.amount.to_i * 100 ,
	        :description => "#{@payment.email}",
	        :currency    => 'cad'
	      )
	      @payment.update_attributes(:payment_status => "Done", :stripe_charge_id => charge.id)
			redirect_to root_path
		else
			render :action => :new
		end
	end

	def refund_amount
	  @payment = Payment.find(params[:id])

	  ch = Stripe::Charge.retrieve(@payment.stripe_charge_id)
      refund = ch.refunds.create
      redirect_to root_path
	end

	def index
		@payments = Payment.where("payment_status='Done'")
	end

	private
	def payment_params
	  params.require(:payment).permit!
	end
end