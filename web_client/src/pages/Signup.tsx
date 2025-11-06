import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Mail, Lock, Eye, EyeOff, Phone, Wifi, Signal, Battery } from "lucide-react";

const Signup = () => {
  const navigate = useNavigate();
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  return (
    <div className="min-h-screen relative overflow-hidden bg-[#FF9B9B]">
      {/* Status Bar */}
      <div className="absolute top-0 left-0 right-0 z-20 px-6 pt-3 flex justify-between items-center text-gray-900">
        <span className="text-sm font-semibold">9:41</span>
        <div className="flex items-center gap-1">
          <Signal className="w-4 h-4" />
          <Wifi className="w-4 h-4" />
          <Battery className="w-5 h-5" />
        </div>
      </div>

      {/* Organic topographic pattern background */}
      <div className="absolute inset-0 opacity-20">
        <svg className="w-full h-full" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <pattern id="topographic-signup" x="0" y="0" width="120" height="120" patternUnits="userSpaceOnUse">
              <path d="M20 60 Q35 40, 60 50 T100 60" stroke="rgba(255,255,255,0.4)" strokeWidth="2" fill="none"/>
              <path d="M15 75 Q30 60, 55 68 T95 78" stroke="rgba(255,255,255,0.4)" strokeWidth="2" fill="none"/>
              <path d="M25 90 Q40 75, 65 83 T105 93" stroke="rgba(255,255,255,0.35)" strokeWidth="1.5" fill="none"/>
              <circle cx="40" cy="85" r="18" stroke="rgba(255,255,255,0.35)" strokeWidth="2" fill="none"/>
              <circle cx="80" cy="30" r="25" stroke="rgba(255,255,255,0.35)" strokeWidth="2" fill="none"/>
              <ellipse cx="60" cy="100" rx="30" ry="18" stroke="rgba(255,255,255,0.35)" strokeWidth="1.5" fill="none"/>
            </pattern>
          </defs>
          <rect width="100%" height="100%" fill="url(#topographic-signup)" />
        </svg>
      </div>

      {/* White curved section */}
      <div className="absolute top-[28%] left-0 right-0 bottom-0">
        <svg className="w-full h-full" viewBox="0 0 430 700" preserveAspectRatio="none">
          <path 
            fill="#ffffff" 
            d="M0,80 Q215,40 430,80 L430,700 L0,700 Z"
          />
        </svg>
      </div>

      {/* Content */}
      <div className="relative z-10 min-h-screen px-6 pt-16">
        <div className="max-w-md mx-auto w-full">
          <div className="mb-8">
            <h1 className="text-[32px] font-bold text-gray-900 mb-1.5">Daftar</h1>
            <div className="w-14 h-0.5 bg-primary rounded-full" />
          </div>

          <div className="space-y-5">
            {/* Email Input */}
            <div>
              <label className="block text-[15px] font-medium text-gray-700 mb-2">
                Email
              </label>
              <div className="relative flex items-center">
                <Mail className="absolute left-0 w-[18px] h-[18px] text-gray-400" />
                <Input
                  type="email"
                  placeholder="musagwanteng@gmail.com"
                  className="pl-7 pr-2 bg-transparent border-0 border-b border-primary/40 rounded-none focus:border-primary focus-visible:ring-0 focus-visible:ring-offset-0 text-[15px] placeholder:text-gray-400/60 h-9 pb-1.5"
                />
              </div>
            </div>

            {/* Phone Input */}
            <div>
              <label className="block text-[15px] font-medium text-gray-700 mb-2">
                Nomor Telepon
              </label>
              <div className="relative flex items-center">
                <Phone className="absolute left-0 w-[18px] h-[18px] text-gray-400" />
                <Input
                  type="tel"
                  placeholder="+62 851 - 6288 - 4545"
                  className="pl-7 pr-2 bg-transparent border-0 border-b border-primary/40 rounded-none focus:border-primary focus-visible:ring-0 focus-visible:ring-offset-0 text-[15px] placeholder:text-gray-400/60 h-9 pb-1.5"
                />
              </div>
            </div>

            {/* Password Input */}
            <div>
              <label className="block text-[15px] font-medium text-gray-700 mb-2">
                Password
              </label>
              <div className="relative flex items-center">
                <Lock className="absolute left-0 w-[18px] h-[18px] text-gray-400" />
                <Input
                  type={showPassword ? "text" : "password"}
                  placeholder="Masukkan Password Anda"
                  className="pl-7 pr-10 bg-transparent border-0 border-b border-primary/40 rounded-none focus:border-primary focus-visible:ring-0 focus-visible:ring-offset-0 text-[15px] placeholder:text-gray-400/60 h-9 pb-1.5"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-0 text-gray-400 hover:text-gray-600 p-0.5"
                >
                  {showPassword ? <EyeOff className="w-[18px] h-[18px]" /> : <Eye className="w-[18px] h-[18px]" />}
                </button>
              </div>
            </div>

            {/* Confirm Password Input */}
            <div>
              <label className="block text-[15px] font-medium text-gray-700 mb-2">
                Confirm Password
              </label>
              <div className="relative flex items-center">
                <Lock className="absolute left-0 w-[18px] h-[18px] text-gray-400" />
                <Input
                  type={showConfirmPassword ? "text" : "password"}
                  placeholder="Konfirmasi Password Anda"
                  className="pl-7 pr-10 bg-transparent border-0 border-b border-primary/40 rounded-none focus:border-primary focus-visible:ring-0 focus-visible:ring-offset-0 text-[15px] placeholder:text-gray-400/60 h-9 pb-1.5"
                />
                <button
                  type="button"
                  onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                  className="absolute right-0 text-gray-400 hover:text-gray-600 p-0.5"
                >
                  {showConfirmPassword ? <EyeOff className="w-[18px] h-[18px]" /> : <Eye className="w-[18px] h-[18px]" />}
                </button>
              </div>
            </div>

            {/* Create Account Button */}
            <Button
              className="w-full bg-primary hover:bg-primary/90 text-white rounded-[20px] py-6 text-[17px] font-medium shadow-md mt-12"
            >
              Create Account
            </Button>

            {/* Login Link */}
            <p className="text-center text-[15px] text-gray-600 pt-2">
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
        <div className="flex justify-center mt-8 pb-3">
          <div className="w-32 h-1.5 bg-gray-900 rounded-full" />
        </div>
      </div>
    </div>
  );
};

export default Signup;
