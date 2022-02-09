% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Ai Kính Sợ Chúa" }
  composer = "Tv. 111"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  e8 f d g |
  c,4 c8 c |
  f (e) d d |
  g2 |
  g8 g a c |
  d8. d16 d8 d |
  b2 |
  e,8 f d g |
  c,4 c8 c |
  f4 e8 d |
  g2 |
  g8 g e' e |
  d8. b16 d8 d |
  c2 \bar "||"
  
  g8 e f16 (e) d8 |
  c8. c16 d8 f |
  g4. g8 |
  e g a c |
  d2 |
  d8 d b16 (a) g8 |
  a8. a16 fs (a) fs8 |
  e4. e8 |
  e a fs16 (e) d8 |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 f d g |
  c,4 c8 c |
  f (e) d c |
  b2 |
  c8 e f a |
  g8. g16 fs8 fs |
  g2 |
  e8 f d g |
  c,4 c8 c |
  f4 c8 c |
  b2 |
  c8 e g g |
  fs8. g16 g8 f! |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Ai kính sợ Chúa Trời, thực hạnh phúc,
  thực hạnh phúc.
  Lòng họ luôn ưa thích huấn giới của Ngài.
  Con cái họ sẽ được hùng cường mãi trên mặt đất
  Và dòng dõi chính nhân được Chúa mến thương.
  <<
    {
      \set stanza = "1."
      Đức công chính của họ tồn tại ngàn năm,
      gia đình giầu sang sinh phúc.
      Ánh sáng nay bừng lên soi kẻ ngay lành,
      là người chính trung từ nhân
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Biết mau mắn cho mượn lòng đầy cảm thương,
	    công việc thực thi ngay chính.
	    Khắp thế nhân mọi nơi nhắc nhở ca ngợi,
	    ngàn đời cũng không chuyển lay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vững tin Chúa khôn rời, sợ gì hiểm nguy,
	    coi thường địch quân hung dữ.
	    Đức chính trung họ luôn chiếu tỏ muôn đời,
	    rộng lượng xót thương bần nhân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Ác nhân thấy cảnh này lòng đầy hận căm,
	    thân tàn tạ bởi ganh ghét.
	    Chúng nghiến răng bậm môi thấy phải thua dài,
	    mọi mộng ước nay tàn phai.
    }
  >>
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
  page-count = #1
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
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
