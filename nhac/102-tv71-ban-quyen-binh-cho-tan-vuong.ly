% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Ban Quyền Bính Cho Tân Vương"
  composer = "Tv. 71"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c8 (d) |
  a'2 ~ |
  a8 g f a |
  d, (f) g g |
  g4 a8 a |
  c f, g16 (f) c8 |
  \slashedGrace { c16 ( } d2) ~ |
  d4 d16 (f) g8 |
  g2 ~ |
  g8 a d,16 (f) d8 |
  c (d) f g |
  a4. a8 |
  g8. g16 g8 c |
  f,2 ~ |
  f4 \bar "||" \break
  
  c8 d |
  c4. f8 |
  e (f) g g |
  a2 |
  r8 a g c |
  f,4 g8. e16 |
  e8 f d e |
  c2 ~ |
  c4 r8 c |
  a' a r e |
  f8. f16 bf8 g |
  a2 ~ |
  a4 a8 c |
  bf4. d8 |
  bf8. g16 c8 e, |
  f2 ~ |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*13
  r4
  c8 d |
  c4. a8 |
  c (d) e e |
  f2 |
  r8 f e e |
  d4 d8. d16 |
  c8 d b! b |
  c2 ~ |
  c4 r8 c |
  f f r c |
  d8. d16 g8 e |
  f2 ~ |
  f4 f8 a |
  g4. f8 |
  g8. e16 d8 c |
  f2 ~ |
  f4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Nguyện Chúa ban quyền bính Ngài cho tân vương,
      Trao công lý vào tay Hoàng tử
      Để Tân vương xét xử dân Người theo công ly,
      Bênh vực mọi kẻ khó nghèo.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Đồi núi đem lại thái hòa cho muôn dân,
	    Đem công lý về cho vạn họ,
	    Người ra tay cứu kẻ cơ cùng và bênh đỡ,
	    Tiêu diệt cường hào ác tà.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Nguyện chúc cho tuổi tác người như kim ô,
	    Hay như bóng nguyệt kia vạn thuở,
	    Tựa sương sa phúc lộc chan hòa Ngài ban xuống,
	    Cho nhuần gội ruộng đất này.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Rộn rã vương hầu các đảo xa muôn nơi
	    Đem theo lễ vật xin thuần phục,
	    Mọi quân vương kính cẩn tôn thờ nơi ngai báu,
	    Muôn người một lòng kính sợ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Giải thoát dân nghèo thống khổ đang kêu than,
	    Thương yêu đoái nhìn ai hèn mọn.
	    Ngài ra tay cứu khỏi bạo tàn và uy hiếp,
	    Tôn trọng từng giọt máu họ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Vạn tuế, thiên hạ tiến vàng cho Tân vương
	    Xin vinh chúc Ngài luôn hiển trị,
	    Và mong sao xứ sở luôn đầy dư gạo thóc,
	    Nương đồng dạt dào lúa vàng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Nguyện chúc danh Ngài vĩnh tồn qua muôn năm,
	    Luôn thơm nức gần xa vạn nẻo,
	    Và muôn dân sẽ biểu dương Ngài thật vinh phúc,
	    Bao dòng tộc được chúc lành.
    }
  >>
  \set stanza = "ĐK:"
  Triều đại Người đua nở hoa công lý,
  Minh trị thái bình tới khi nao tuế nguyệt chẳng còn.
  Người thống lãnh từ biển này tới biển kia,
  Từ sông Cả đến tận cùng cõi địa cầu.
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
