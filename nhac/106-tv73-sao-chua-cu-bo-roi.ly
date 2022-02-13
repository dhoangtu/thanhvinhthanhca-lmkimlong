% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Sao Chúa Cứ Bỏ Rơi" }
  composer = "Tv. 73"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \autoPageBreaksOff
  \partial 4 a8 (bf16 a) |
  g4. g8 |
  f a d, (f) |
  g4. g8 |
  f f g (a) |
  e4. f16 d |
  g8 e e g |
  a2 ~ |
  a4 d8 e16 (d) |
  cs4. d8 |
  bf8 bf d16 (e) d8 |
  a4. f8 |
  d8. c16 d8 f |
  g4. bf16 a |
  a8 g e f16 (e) |
  d2 ~ |
  \partial 4 d4 \bar "||"
  
  \pageBreak
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key d \major
  \partial 4 d4 |
  a'4. b16 a |
  fs8 g e d16 d |
  b'4 r8 d |
  cs cs16 cs cs8 e16 d |
  a4 r8 b |
  a fs r g |
  e4. d8 |
  b'4 cs8 d16 d |
  a8. b16 g8 e |
  d4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*15
  r4
  
  d4 |
  fs4. g16 fs |
  d8 e cs b16 b |
  g'4 r8 fs |
  a a16 a a8 g16 g |
  fs4 r8 g |
  fs d r e |
  cs4. b8 |
  g'4 a8 g16 g |
  fs8. e16 d8 cs |
  d4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa ơi sao Ngài cứ bỏ rơi,
      sao bừng bừng nổi giận
      với đoàn chiên Ngài hằng chăn dắt
      Xin nhớ lại dân tộc Ngài đã quy tụ,
      sản nghiệp Ngài từng chọn riêng,
      núi Si -- on nơi Ngài hiển trị.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chúa thương xin đặt bước
	    vào nơi quân thù tàn phá này,
	    thánh điện xưa rầy thực hoang phế
	    Đây chính là nơi hội họp của dân Ngài,
	    bây giờ địch thù gầm vang,
	    chúng trương lên quân kỳ khải hoàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúng như vung rìu giữa rừng hoang,
	    cho triệt hạ cửa đền,
	    thánh điện châm mồi lửa thiêu đốt
	    Trong xứ này nơi thờ phượng chúng thiêu rụi,
	    lại còn thì thầm bảo nhau:
	    phá tan hoang, san bằng hết trọi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Thế nhưng muôn đời Chúa hiển vinh,
	    đêm ngày là của Ngài,
	    Đấng dựng nên mặt trời, tinh tú
	    Dương thế này, tay Ngài vạch mức chia miền,
	    phân biệt vào hạ, lập đông,
	    chúng con trông mong Ngài nhớ lại.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúa ơi xin đừng mãi bỏ quên
	    dân nghèo hèn của Ngài,
	    nhớ lại xưa Ngài lập giao ước
	    Xin đứng dậy, xin biện hộ cứu dân Ngài,
	    để người nghèo hèn mừng vui,
	    hát vang lên ca tụng Chúa hoài.
    }
  >>
  \set stanza = "ĐK:"
  Lạy Chúa, tới bao giờ đối phương còn nhạo báng,
  quân thù còn nhục mạ thánh danh Ngài,
  Cánh tay Ngài, cánh tay hùng dũng
  sao cứ rút lại chẳng can thiệp gì?
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  ragged-bottom = ##t
}

TongNhip = {
  \key f \major \time 2/4
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
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
