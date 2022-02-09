% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Hiển Trị" }
  composer = "Tv. 96"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a8 (g) f (g) |
  d4. c16 c |
  f8 f e d |
  g4. bf16 bf |
  g8 g bf c |
  c4 r8 a16 a |
  c8 a16 (g) f8 g16 (f) |
  d4. d16 e |
  c8 g' g a16 (g) |
  f4 r8 \bar "||" \break
  
  c |
  a'4. a16 a |
  bf8 g c c |
  e,4 d16 (f) d8 |
  c4. c8 |
  a' (bf) g g |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*9
  r4.
  c8 |
  f4. f16 f |
  g8 f e d |
  c4 b!8 [b] |
  c4. c8 |
  f (g) e e |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa hiển trị, Địa cầu hỡi hãy nhảy mừng lên,
      Reo vui nào, quần đảo xa xôi,
      Mây u ám bao phủ quanh Ngài,
      bệ ngai là công minh chính trực.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Có lửa hồng Mở đường đốt cháy mọi địch quân,
	    Ánh chớp Ngài rạng soi dương gian,
	    Khi chiêm ngắm địa cầu run sợ,
	    bao núi đồi tan như sáp mềm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Bái phục Ngài, Từng vị thánh với mọi thần minh,
	    Si -- on vừa được nghe hân hoan,
	    Giu -- đa cũng hớn hở nhảy mừng
	    do phán định công minh của Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Chính bởi Ngài, Vạn lạy Chúa,
	    Đấng cao cả thay,
	    Vẫn giữ gìn mọi kẻ kiên trung,
	    Cho xa thoát bao bọn hung ta,
	    uy thế vượt trên muôn lãnh thần.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Trước nhan Ngài,
	    Nào mừng rỡ hỡi kẻ lòng ngay,
	    Ánh sáng ngời rạng kẻ công minh,
	    Luôn luôn nhớ suy tưởng danh Ngài,
	    dâng tiến lời tôn vinh cảm tạ.
    }
  >>
  \set stanza = "ĐK:"
  Trời xanh tuyên xưng Chúa là Đấng chính trực,
  Các dân tộc được thấy vinh quang Ngài.
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
  page-count = 1
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
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
