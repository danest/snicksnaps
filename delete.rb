Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "cars" }).paginate(:page => params[:page], :per_page => 30)


Product.all(:limit => 10000).destroy && Product.all(:limit => 3000).destroy && Product.all(:limit => 3000).destroy && Product.all(:limit =
> 3000).destroy && Product.all(:limit => 3000).destroy && Product.all(:limit => 3000).destroy && Product.all(:limit => 3000).destroy

  @products = Product.all(:conditions => {:city => 'washington-dc', :created_at.lt => 1.day.ago, :category => 'cars' })

Product.all(:conditions => {:city => city, :created_at.gt => 1.week.ago, :category => category })



yes big boy
yes big boy
yes big boy
yes big boy
yes big boy
yes big boy
yes big boy
