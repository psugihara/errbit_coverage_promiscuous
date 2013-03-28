require 'airbrake'

namespace :err do
  ERR_MESSAGES = [
    "error1",
    "error2",
    "error3",
    "error4",
    "error5",
    "error6",
    "error7",
    "error8",
    "error9",
    "error10",
    "error11",
    "error12",
    "error13",
    "error14",
    "error15",
    "error16",
    "error17",
    "error18",
    "error19",
    "error20",
    "error21",
    "error22",
    "error23",
    "error24",
    "error25",
    "error26",
    "error27",
  ]

  ERR_BACKTRACES = [
    "controller_a.rb",
    "controller_b.rb",
    "controller_c.rb",
    "controller_d.rb",
    "controller_e.rb",
    "controller_f.rb",
    "controller_g.rb",
    "controller_h.rb",
    "controller_i.rb",
    "controller_j.rb",
    "controller_k.rb",
    "controller_l.rb",
    "controller_m.rb",
    "controller_n.rb",
    "controller_o.rb",
    "controller_p.rb",
    "controller_q.rb",
    "controller_r.rb",
    "controller_s.rb",
    "controller_t.rb",
    "controller_u.rb",
    "controller_v.rb",
    "controller_w.rb",
    "controller_x.rb",
    "controller_y.rb",
    "controller_z.rb",
    "model_a.rb",
    "model_b.rb",
    "model_c.rb",
    "model_d.rb",
    "model_e.rb",
    "model_f.rb",
    "model_g.rb",
    "model_h.rb",
    "model_i.rb",
    "model_j.rb",
    "model_k.rb",
    "model_l.rb",
    "model_m.rb",
    "model_n.rb",
    "model_o.rb",
    "model_p.rb",
    "model_q.rb",
    "model_r.rb",
    "model_s.rb",
    "model_t.rb",
    "model_u.rb",
    "model_v.rb",
    "model_w.rb",
    "model_x.rb",
    "model_y.rb",
    "model_z.rb"
  ]

  desc "Throw some errors."
  task :throw, [:num_errors] => [:environment] do |t, args|
    num_errors = args[:num_errors].to_i
    log_interval = num_errors / 100.0

    puts "Throwing #{num_errors} errors..."

  	(1..num_errors).each do |i|
      e = Exception.new(ERR_MESSAGES[rand(ERR_MESSAGES.length)])
      e.set_backtrace(ERR_BACKTRACES[rand(ERR_BACKTRACES.length)])
      Airbrake.notify(e, :component => nil, :cgi_data => ENV)
      if i % log_interval == 0
        puts i
      end
    end
  end

end
