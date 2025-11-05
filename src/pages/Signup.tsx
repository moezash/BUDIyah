import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Mail, Lock, Eye, EyeOff, Phone } from "lucide-react";

const Signup = () => {
  const navigate = useNavigate();
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  return (
    <div className="min-h-screen relative overflow-hidden bg-gradient-to-br from-[#FF9B9B] to-[#FFB5B5]">
      {/* Organic topographic pattern background */}
      <div className="absolute inset-0 opacity-30">
        <svg className="w-full h-full" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <pattern id="topographic-signup" x="0" y="0" width="100" height="100" patternUnits="userSpaceOnUse">
              <path d="M20 50 Q30 30, 50 40 T80 50" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
              <path d="M10 60 Q25 45, 45 55 T75 65" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
              <path d="M15 30 Q35 20, 55 25 T85 35" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
              <circle cx="30" cy="70" r="15" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
              <circle cx="70" cy="25" r="20" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
              <ellipse cx="50" cy="80" rx="25" ry="15" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
            </pattern>
          </defs>
          <rect width="100%" height="100%" fill="url(#topographic-signup)" />
        </svg>
      </div>

      {/* White curved section */}
      <div className="absolute top-1/4 left-0 right-0 bottom-0">
        <svg className="w-full h-full" viewBox="0 0 1440 900" preserveAspectRatio="none">
          <path 
            fill="#ffffff" 
            d="M0,100 Q360,40 720,80 T1440,60 L1440,900 L0,900 Z"
          />
        </svg>
      </div>

      {/* Content */}
      <div className="relative z-10 min-h-screen px-8 pt-16">
        <div className="max-w-md mx-auto">
          <div className="mb-8">
            <h1 className="text-4xl font-bold text-gray-900 mb-1">Daftar</h1>
            <div className="w-16 h-1 bg-primary rounded-full" />
          </div>

          <div className="space-y-5">
            {/* Email Input */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Email
              </label>
              <div className="relative">
                <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                <Input
                  type="email"
                  placeholder="musagwanteng@gmail.com"
                  className="pl-10 bg-white border-0 border-b-2 border-primary/30 rounded-none focus:border-primary focus-visible:ring-0 focus-visible:ring-offset-0"
                />
              </div>
            </div>

            {/* Phone Input */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Nomor Telepon
              </label>
              <div className="relative">
                <Phone className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                <Input
                  type="tel"
                  placeholder="+62 851 - 6288 - 4545"
                  className="pl-10 bg-white border-0 border-b-2 border-primary/30 rounded-none focus:border-primary focus-visible:ring-0 focus-visible:ring-offset-0"
                />
              </div>
            </div>

            {/* Password Input */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Password
              </label>
              <div className="relative">
                <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                <Input
                  type={showPassword ? "text" : "password"}
                  placeholder="Masukkan Password Anda"
                  className="pl-10 pr-10 bg-white border-0 border-b-2 border-primary/30 rounded-none focus:border-primary focus-visible:ring-0 focus-visible:ring-offset-0"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                >
                  {showPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
                </button>
              </div>
            </div>

            {/* Confirm Password Input */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Confirm Password
              </label>
              <div className="relative">
                <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                <Input
                  type={showConfirmPassword ? "text" : "password"}
                  placeholder="Konfirmasi Password Anda"
                  className="pl-10 pr-10 bg-white border-0 border-b-2 border-primary/30 rounded-none focus:border-primary focus-visible:ring-0 focus-visible:ring-offset-0"
                />
                <button
                  type="button"
                  onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                >
                  {showConfirmPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
                </button>
              </div>
            </div>

            {/* Create Account Button */}
            <Button
              className="w-full bg-primary hover:bg-primary/90 text-white rounded-2xl py-6 text-lg font-medium shadow-lg mt-8"
            >
              Create Account
            </Button>

            {/* Login Link */}
            <p className="text-center text-gray-600">
              Sudah punya akun?{" "}
              <button
                onClick={() => navigate("/login")}
                className="text-primary font-semibold hover:text-primary/80"
              >
                Login
              </button>
            </p>
          </div>
        </div>

        {/* Bottom indicator */}
        <div className="flex justify-center mt-8">
          <div className="w-32 h-1.5 bg-gray-900 rounded-full" />
        </div>
      </div>
    </div>
  );
};

export default Signup;
