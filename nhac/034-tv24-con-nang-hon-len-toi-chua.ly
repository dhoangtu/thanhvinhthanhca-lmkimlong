% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Con Nâng Hồn Lên Tới Chúa"
  composer = "Tv. 24"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8. a16 |
  e8 a4 b8 |
  c4. b8 |
  e4 d8. d16 |
  d8 c (d) c |
  b2 ~ |
  b4 a8. g!?16 |
  g8 a4 b8 |
  \slashedGrace { d,16 ( } e4) r8 c' |
  c d b8. b16 |
  f'8 e4 e,8 |
  c'8. [b16] b8 [a] ~ |
  a2 \bar "||"
  
  \slashedGrace { e16 ( } a8.) f16 e8 b |
  \slashedGrace { e16 (f } e4.) e16 e |
  f8 c16 (e) a8 c |
  b2 ~ |
  b4 c8. g16 |
  a8 a d c16 (d) |
  e4. e16 c |
  c8 e c16 (b) g8 |
  a2 ~ |
  a4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8. a16 |
  e8 a4 gs8 |
  a4. a8 |
  gs4 b8. b16 |
  b8 a (b) a |
  e2 ~ |
  e4 a8. g!?16 |
  g8 a4 b8 |
  \slashedGrace { d,16 ( } e4) r8 a |
  a b gs8. gs16 |
  a8 e4 e8 |
  a8. <a d,>16 <gs e>8 c, ~ |
  c2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Con nâng hồn lên tới Chúa, lạy Chúa,
  con luôn tin tưởng nơi Ngài.
  Xin đừng để con xấu hổ,
  đừng để quân thù nhạo báng con,
  lạy Chúa con tôn thờ.
  <<
    {
      \set stanza = "1."
      Chẳng ai trông cậy Chúa
      mà lại phải nhục nhã hổ ngươi,
      Chỉ người nào tự dưng phản phúc
      mới nhục nhằn xấu hổ mà thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chỉ cho con đường Chúa
	    và tỏ lối Ngài con dõi theo.
	    Khấn nguyện Ngài bảo ban dạy dỗ,
	    dẫn hồn này bước theo đường ngay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Sớm hôm trông cậy Chúa,
	    Ngài từ ái và luôn cứu nguy.
	    Cúi lạy Ngài đừng quên tình nghĩa
	    đã biểu lộ mãi tự ngàn xưa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Tuổi xuân bao lầm lỗi,
	    trông mong Chúa đừng ghi nhớ chi,
	    Hãy biểu lộ tình thương của Chúa
	    đoái nhìn và xót thương mà thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Những ai tôn sợ Chúa
	    được Ngài chỉ dậy cho lối đi,
	    Sẽ một đời mừng vui hạnh phúc,
	    tới hậu duệ vẫn hưởng lộc ân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Mắt con trông về Chúa,
	    kìa dò lưới bủa giăng khắp nơi,
	    Chúa nhìn lại và thương giải cứu
	    chút phận này khốn khổ lẻ loi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Náu thân bên lòng Chúa,
	    Ngài đừng nỡ để con hổ ngươi,
	    Hãy bảo toàn và thương giải thoát
	    kẻ một niềm mến yêu cậy trông.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
  bottom-margin = 10\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  %page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
